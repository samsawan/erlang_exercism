-module(sieve).

-export([sieve/1, test_version/0]).

sieve(1) -> [];
sieve(N) ->  sieve([], lists:seq(3, N, 2)).

sieve(PrimeList, []) -> [2 | lists:reverse(PrimeList)];
sieve(PrimeList, [PrimeNum | RemainingNums]) ->
	sieve([PrimeNum | PrimeList], lists:filter(fun(Num) -> Num rem PrimeNum =/= 0 end, RemainingNums)).

test_version() -> 1.
