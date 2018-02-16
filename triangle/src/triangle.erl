-module(triangle).

-export([kind/3, test_version/0]).
-include_lib("eunit/include/eunit.hrl").

kind(A, B, C) ->
	case invalid_triangle(A, B, C) of
		false -> analyze_triangle(A, B, C);
		ErrorReason -> ErrorReason
	end.

invalid_triangle(A, B, C) when A =< 0 orelse B =< 0 orelse C =< 0 ->
	{error, "all side lengths must be positive"};
invalid_triangle(A, B, C) ->
	ViolatesTriangleEqualityFunc = fun(SideA, SideB, SideC) -> SideA + SideB < SideC end,
	lists:foldl(
		fun({First, Second, Third}, false) ->
			case ViolatesTriangleEqualityFunc(First, Second, Third) of
				true -> {error, "side lengths violate triangle inequality"};
				false -> false
			end;
			(_, Error) -> Error
		end,
		false,
		[{A, B, C}, {B, C, A}, {A, C, B}]
	).

analyze_triangle(_A, _A, _A) -> equilateral;
analyze_triangle(_A, _A, _B) -> isosceles;
analyze_triangle(_A, _B, _A) -> isosceles;
analyze_triangle(_B, _A, _A) -> isosceles;
analyze_triangle(_, _, _) -> scalene.

test_version() -> 1.
