-module(clock).

-export([create/2, is_equal/2, minutes_add/2, to_string/1, test_version/0]).

create(Hours, Minutes) ->
	{CalculatedHours, CalculatedMinutes} = add_minutes_to_hours(positive_hours(Hours), Minutes),
	[{hours, rollover_hours(CalculatedHours)}, {minutes, CalculatedMinutes}].

is_equal(ClockA, ClockB) ->
  undefined.

minutes_add(Clock, Minutes) ->
  undefined.

to_string([{hours, Hours}, {minutes, Minutes}]) ->
	format_hours(Hours) ++ ":" ++ format_minutes(Minutes).

test_version() -> 1.

positive_hours(Hours) when Hours >= 0 -> Hours;
positive_hours(Hours) -> positive_hours(Hours + 24).

add_minutes_to_hours(Hours, Minutes) when Minutes < 60 -> {Hours, Minutes};
add_minutes_to_hours(Hours, Minutes) -> add_minutes_to_hours(Hours + 1, Minutes - 60).

rollover_hours(Hours) -> Hours rem 24.

format_minutes(Minutes) when Minutes < 10 -> unicode:characters_to_list([$0, integer_to_list(Minutes)]);
format_minutes(Minutes) -> integer_to_list(Minutes).

format_hours(Hours) when Hours < 10 -> unicode:characters_to_list([$0, integer_to_list(Hours)]);
format_hours(Hours) -> integer_to_list(Hours).

