-module(pangram).

-export([is_pangram/1, test_version/0]).

-define(ALL_LETTERS, "abcdefghijklmnopqrstuvwxyz").

is_pangram(Sentence) ->
    TruncatedList =
    lists:foldl(
    	fun(Char, LetterList) -> lists:delete(Char, LetterList) end,
    	?ALL_LETTERS,
    	string:to_lower(Sentence)
  	),
  	case TruncatedList of
  		"" -> true;
  		_ -> false
  	end.

test_version() -> 1.
