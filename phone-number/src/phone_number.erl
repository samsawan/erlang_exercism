-module(phone_number).

-export([number/1, areacode/1, pretty_print/1, test_version/0]).

number(String) ->
	CleanedNumber = clean_number(String),
	valid_number(CleanedNumber).

areacode(String) ->
  undefined.

pretty_print(String) ->
  undefined.

test_version() -> 1.

clean_number(String) ->
	lists:filter(
  	fun(NumChar) -> NumChar >= $0 andalso NumChar =< $9 end,
  	String
	).

valid_number([CountryCode | LocalNumber] = FullNumber) when CountryCode =:= $1 andalso length(FullNumber) =:= 11 -> LocalNumber;
valid_number(Number) when length(Number) =:= 10 -> Number;
valid_number(_) -> "0000000000".
