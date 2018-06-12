-module(parallel_letter_frequency).

-export([dict/1, test_version/0]).

dict(Strings) ->
	EmptyDict = dict:new(),
	Counts = lists:map(fun(S) -> determine_count(S, EmptyDict) end, Strings),
	combine_counts(Counts, EmptyDict).

determine_count([], Dict) -> Dict;
determine_count([Letter | Letters], Dict) -> determine_count(Letters, dict:update_counter(Letter, 1, Dict)).

combine_counts([], Combined) -> Combined;
combine_counts([Count | Counts], Combined) -> combine_counts(Counts, dict:merge(fun(_, V1, V2) -> V1 + V2 end, Count, Combined)).

test_version() -> 1.

