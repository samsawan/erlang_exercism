-module(clock).

-export([create/2, is_equal/2, minutes_add/2, to_string/1, test_version/0]).

create(Hours, Minutes) ->
	{CalculatedHours, CalculatedMinutes} = roll_minutes_into_hours(Hours, Minutes),
	[{hours, rollover_hours(positive_hours(CalculatedHours))}, {minutes, CalculatedMinutes}].

is_equal(ClockA, ClockB) -> ClockA =:= ClockB.

minutes_add([{hours, Hours}, {minutes, PreviousMinutes}], Minutes) -> create(Hours, PreviousMinutes + Minutes).

to_string([{hours, Hours}, {minutes, Minutes}]) -> format(Hours) ++ ":" ++ format(Minutes).

test_version() -> 1.

positive_hours(Hours) when Hours >= 0 -> Hours;
positive_hours(Hours) -> positive_hours(Hours + 24).

roll_minutes_into_hours(Hours, Minutes) when Minutes < 60 andalso Minutes >= 0 -> {Hours, Minutes};
roll_minutes_into_hours(Hours, Minutes) when Minutes < 0 -> roll_minutes_into_hours(Hours - 1, Minutes + 60);
roll_minutes_into_hours(Hours, Minutes) -> roll_minutes_into_hours(Hours + 1, Minutes - 60).

rollover_hours(Hours) -> Hours rem 24.

format(Unit) when Unit < 10 -> unicode:characters_to_list([$0, integer_to_list(Unit)]);
format(Unit) -> integer_to_list(Unit).
