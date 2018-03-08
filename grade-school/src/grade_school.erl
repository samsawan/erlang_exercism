-module(grade_school).

-export([add/3, get/2, sort/1, new/0, test_version/0]).

-record(student, {name, grade}).

new() -> [].

add(Name, Grade, School) -> [#student{name = Name, grade = Grade} | School].

get(Grade, Students) ->
	lists:filtermap(
		fun(#student{grade = StudentGrade, name = Name}) ->
			case StudentGrade =:= Grade of
				true -> {true, Name};
				false -> false
			end
		end,
		Students
	).

sort(School) ->
	UniqueGrades =
	lists:foldl(
		fun(#student{name = Name, grade = Grade}, AccMap) ->
			ExistingNames = maps:get(Grade, AccMap, []),
			maps:put(Grade, lists:sort([Name | ExistingNames]), AccMap)
		end,
		maps:new(),
		School
	),
	maps:to_list(UniqueGrades).


test_version() -> 1.
