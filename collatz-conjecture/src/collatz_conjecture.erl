-module(collatz_conjecture).

-export([steps/1, test_version/0]).


steps(N) when N =< 0 -> {error, "Only positive numbers are allowed"};
steps(N) -> steps(N, 0).

test_version() -> 2.

steps(1, StepCount) -> StepCount;
steps(Value, StepCount) when Value rem 2 =:= 0 -> steps(Value div 2, StepCount + 1);
steps(Value, StepCount) -> steps(Value * 3 + 1, StepCount + 1).
