-module(sum_of_multiples).

-export([sumOfMultiples/2, test_version/0]).

sumOfMultiples(Multiples, N) ->
	UpperLimit = N - 1,
	lists:sum(
		lists:foldl(
			fun(Multiple, PreviousMultiples) ->
				CurrentMultiples = lists:seq(0, UpperLimit, Multiple),
				lists:umerge(CurrentMultiples, PreviousMultiples)
			end,
			[],
			Multiples
			)
		).

test_version() -> 1.
