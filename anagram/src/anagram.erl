-module(anagram).

-export([find/2, test_version/0]).

find(Word, Candidates) ->
	LowerWord = string:to_lower(Word),
	lists:foldl(
		fun(Candidate, Anagrams) ->
			LowerCandidate = string:to_lower(Candidate),
			case not (LowerCandidate =:= LowerWord) andalso (lists:sort(LowerCandidate) =:= lists:sort(LowerWord)) of
				true -> Anagrams ++ [Candidate];
				false -> Anagrams
			end
		end,
		[],
	Candidates).

test_version() -> 1.
