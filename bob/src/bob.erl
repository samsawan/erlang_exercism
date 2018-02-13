-module(bob).

-export([response/1, test_version/0]).

response([]) -> "Fine. Be that way!";
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
		fun check_for_silence/1,
		fun check_for_shouting/1,
		fun check_for_question/1
	]),
	case element(1, Response) of
		true -> element(2, Response);
		false -> "Whatever."
	end.

test_version() -> 2.

check_for_silence(String) ->
	A = clear_whitespace(String),
	io:format("samsawan 	HERES A: ~p", [A]),
	case A of
		"" -> {true, "Fine. Be that way!"};
		_ -> {false, String}
	end.

check_for_question(String) ->
	case hd(lists:reverse(string:strip(String))) =:= $? of
		true -> {true, "Sure."};
		false -> {false, String}
	end.

check_for_shouting(String) ->
	case string:to_upper(String) =:= String andalso re:run(String, <<"[A-Z]">>) =/= nomatch of
		true -> {true, "Whoa, chill out!"};
		false -> {false, String}
	end.

clear_whitespace(String) ->
	lists:filter(fun(Char) -> not lists:member(Char, "\n \r\t") end, String).
