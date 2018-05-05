-module(isbn_verifier).

-export([is_valid/1, test_version/0]).

is_valid(Isbn) ->
	FilterMapFunc =
		fun(C) ->
			case (C >= $0 andalso C =< $9) orelse C == $X of
				true -> {true, C - $0};
				false -> false
		end
	end,
	SanitizedIsbn = lists:filtermap(FilterMapFunc, Isbn),
	ConcatVals = lists:zip(SanitizedIsbn, lists:reverse(lists:seq(1, 10))),
	lists:foldl(fun({A,B}, Sum) -> A * B + Sum end, 0, ConcatVals) rem 11 == 0.

test_version() -> 1.
