-module(hamming).

-export([distance/2, test_version/0]).


distance(Strand1, Strand2) when length(Strand1) =/= length(Strand2) ->
	{error, "left and right strands must be of equal length"};
distance(Strand1, Strand2) ->
	lists:foldl(
		fun(Index, DiffCount) ->
			case string:substr(Strand1, Index, 1) =:= string:substr(Strand2, Index, 1) of
				true -> DiffCount;
				false -> DiffCount + 1
			end
		end,
		0,
		lists:seq(1, length(Strand1) + 1)
	).

test_version() -> 2.
