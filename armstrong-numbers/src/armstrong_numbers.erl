-module(armstrong_numbers).

-export([is_armstrong_number/1, test_version/0]).

is_armstrong_number(N) ->
	Digits = get_digits(N),
	Pow = length(Digits),
	RaiseFunc = fun(Num) -> trunc(math:pow(Num, Pow)) end,
	N =:= lists:foldl(fun(Digit, Acc) -> Acc + RaiseFunc(Digit) end, 0, Digits).

get_digits(N) -> get_digits(N rem 10, N div 10, []).

get_digits(Digit, 0, Digits) -> [Digit | Digits];
get_digits(Digit, Quotient, Digits) -> get_digits(Quotient rem 10, Quotient div 10, [Digit | Digits]).

test_version() -> 1.
