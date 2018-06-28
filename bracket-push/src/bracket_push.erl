-module(bracket_push).

-export([is_paired/1, test_version/0]).

-define(BASE_STRING, "").

is_paired(Str) ->
	{RemainingChars, Result} =
	lists:foldl(
		fun(Char, {RelevantChars, true}) ->
					case analyze_char(Char) of
						open -> {[Char | RelevantChars], true};
						close -> is_match(Char, RelevantChars);
						ignore -> {RelevantChars, true}
					end;
			  (_, _) ->
			  	{?BASE_STRING, false}
		end,
		{?BASE_STRING, true},
		Str
	),
	case RemainingChars =:= ?BASE_STRING of
		true -> Result;
		false -> false
	end.

analyze_char(Char) when Char =:= ${ orelse Char =:= $( orelse Char =:= $[ -> open;
analyze_char(Char) when Char =:= $} orelse Char =:= $) orelse Char =:= $] -> close;
analyze_char(_) -> ignore.

is_match($], [$[ | RemainingChars]) -> {RemainingChars, true};
is_match($), [$( | RemainingChars]) -> {RemainingChars, true};
is_match($}, [${ | RemainingChars]) -> {RemainingChars, true};
is_match(_, _) -> {?BASE_STRING, false}.

test_version() -> 1.
