-module(pangram).

-export([is_pangram/1, test_version/0]).

-define(ALL_LETTERS, "abcdefghijklmnopqrstuvwxyz").

is_pangram(Sentence) ->
    UnusedLetters =
    lists:foldl(
    	fun(_, "") -> "";
    	   (Char, RemainingLetters) -> lists:delete(Char, RemainingLetters) end,
    	?ALL_LETTERS,
    	string:to_lower(Sentence)
  	),
  	case UnusedLetters of
  		"" -> true;
  		_ -> false
  	end.

test_version() -> 1.
