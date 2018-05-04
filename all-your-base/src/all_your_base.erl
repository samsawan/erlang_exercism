-module(all_your_base).
-define(BASE_KEY, ok).

-export([test_version/0, convert/3]).

test_version() -> 1.

convert(Digits, SrcBase, DstBase) ->
	case valid(Digits, SrcBase, DstBase) of
		?BASE_KEY ->
			Num = base_ten_converter(Digits, SrcBase),
			{ok, num_to_list(Num, [], DstBase)};
		Invalid -> Invalid
	end.

valid(Digits, SrcBase, DstBase) ->
	lists:foldl(
		fun(_, {error, Reason} = Error) -> Error;
			 (VFunc, ?BASE_KEY) -> VFunc()
		end,
		?BASE_KEY,
		generate_validation_checks(Digits, SrcBase, DstBase)
	).

generate_validation_checks(Digits, SrcBase, DstBase) ->
	[
		fun() -> invalid_base_check(SrcBase, DstBase) end,
		fun() -> negative_number_check(Digits) end,
		fun() -> higher_digit_check(Digits, SrcBase) end
	].

base_ten_converter(Digits, SrcBase) ->
	PowerFunc = fun(P) -> trunc(math:pow(SrcBase, P)) end,
	GeneratePowListFunc = fun() -> lists:reverse(lists:seq(0, length(Digits) - 1)) end,

	CombinedList = lists:zip(Digits, GeneratePowListFunc()),
	lists:foldl(
		fun({Digit, Pow}, Sum) -> Sum + (Digit * (PowerFunc(Pow))) end,
		0,
		CombinedList
).

num_to_list(0, NumList, _) ->
	NumList;
num_to_list(Num, NumList, DstBase) ->
	num_to_list(Num div DstBase, [Num rem DstBase | NumList], DstBase).

negative_number_check(Digits) ->
	case lists:any(fun(D) -> D < 0 end, Digits) of
		true -> {error, negative};
		false -> ?BASE_KEY
	end.

higher_digit_check(Digits, SrcBase) ->
	case lists:any(fun(D) -> D >= SrcBase end, Digits) of
		true -> {error, not_in_base};
		false -> ?BASE_KEY
	end.

invalid_base_check(SrcBase, _) when SrcBase < 2 -> {error, invalid_src_base};
invalid_base_check(_, DstBase) when DstBase < 2 -> {error, invalid_dst_base};
invalid_base_check(_, _) -> ?BASE_KEY.
