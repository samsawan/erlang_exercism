-module(all_your_base).

-export([test_version/0, convert/3]).

convert(Digits, SrcBase, DstBase) ->
 	Num = base_ten_converter(Digits, SrcBase),
 	{ok, num_to_list(Num, [], DstBase)}.

 base_ten_converter(Digits, SrcBase) ->
 	PowerFunc = fun(P) -> trunc(math:pow(SrcBase, P)) end,
 	GeneratePowListFunc = fun() -> lists:reverse(lists:seq(0, length(Digits) - 1)) end,
 	CombinedList = lists:zip(Digits, GeneratePowListFunc()),
 	lists:foldl(
 		fun({Digit, Pow}, Sum) ->
 			Sum + (Digit * (PowerFunc(Pow)))
 		end,
 		0,
 		CombinedList
	).

num_to_list(0, NumList, _) -> NumList;
num_to_list(Num, NumList, DstBase) -> num_to_list(Num div DstBase, [Num rem DstBase | NumList], DstBase).

test_version() -> 1.
