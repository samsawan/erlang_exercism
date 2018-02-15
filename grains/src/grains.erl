-module(grains).

-export([square/1, total/0, test_version/0]).

square(N) -> trunc(math:pow(2, N -1)).

total() -> square(65) - 1.

test_version() -> 1.
