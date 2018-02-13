-module(bob).

-export([response/1, test_version/0]).

response(String) ->
	Response =
	lists:foldl(fun(TransformFunc, BobResponse) ->
		case BobResponse of
			{false, String} -> TransformFunc(String);
			FinalResponse -> FinalResponse
		end
	end,
	{false, String},
	[
		fun check_for_shouting/1,
		fun check_for_question/1
	]),
	case element(1, Response) of
		true -> element(2, Response);
		false -> "Whatever."
	end.

test_version() -> 2.

check_for_question(String) ->
	case hd(lists:reverse(String)) =:= $? of
		true -> {true, "Sure."};
		false -> {false, String}
	end.

check_for_shouting(String) ->
	case string:to_upper(String) =:= String of
		true -> {true, "Whoa, chill out!"};
		false -> {false, String}
	end.
