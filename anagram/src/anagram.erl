-module(anagram).

-export([find/2, test_version/0]).

find(Word, Candidates) ->
	LowerWord = string:to_lower(Word),
	lists:foldl(
		fun(Candidate, Anagrams) ->
			case is_anagram(LowerWord, string:to_lower(Candidate)) of
				true -> Anagrams ++ [Candidate];
				false -> Anagrams
			end
		end,
		[],
	Candidates).

test_version() -> 1.

is_anagram(_Word, _Word) -> false;
is_anagram(Word, Candidate) when length(Word) =/= length(Candidate) -> false;
is_anagram(Word, Candidate) ->
	case lists:foldl(fun(Char, RemainingCandidate) -> lists:delete(Char, RemainingCandidate) end, Candidate, Word) of
		"" -> true;
		_ -> false
	end.
