-module(gigasecond).

-export([from/1, test_version/0]).

-define(DEFAULT_TIME, {0, 0, 0}).
-define(GIGASECOND, 1000000000).

from({_, _, _} = Date) -> gs_calc({Date, ?DEFAULT_TIME});
from({_, _} = DateTime) -> gs_calc(DateTime).

test_version() -> 1.

gs_calc(DateTime) ->
	Secs = calendar:datetime_to_gregorian_seconds(DateTime),
	calendar:gregorian_seconds_to_datetime(Secs + ?GIGASECOND).
