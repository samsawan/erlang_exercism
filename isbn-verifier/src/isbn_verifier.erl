-module(isbn_verifier).

-export([is_valid/1, test_version/0]).

is_valid(Isbn) ->
	FindValFunc =
	fun($X) -> 10;
	   (C) -> C - $0
	end,
	FilterMapFunc =
	fun(C) ->
		case (C >= $0 andalso C =< $9) orelse C == $X of
			true -> {true, FindValFunc(C)};
			false -> false
		end
	end,
	SanitizedIsbn = lists:filtermap(FilterMapFunc, Isbn),
	case length(SanitizedIsbn) == 10 of
		true ->
			ConcatVals = lists:zip(SanitizedIsbn, lists:reverse(lists:seq(1, 10))),
			lists:foldl(fun({A,B}, Sum) -> A * B + Sum end, 0, ConcatVals) rem 11 == 0;
		false -> false
	end.

test_version() -> 1.
