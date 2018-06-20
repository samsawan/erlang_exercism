-module(roman_numerals).

-export([numerals/1, test_version/0]).

numerals(Number) -> numerals(Number, "").

numerals(0, RomanNumeral) ->
	RomanNumeral;
numerals(Number, RomanNumeral) ->
	{NewNumber, Numeral} = determine_numeral(Number),
	numerals(NewNumber, RomanNumeral ++ Numeral).

determine_numeral(Num) when Num >= 1000 -> {Num - 1000, "M"};
determine_numeral(Num) when Num >= 900 -> {Num - 900, "CM"};
determine_numeral(Num) when Num >= 500 -> {Num - 500, "D"};
determine_numeral(Num) when Num >= 400 -> {Num - 400, "CD"};
determine_numeral(Num) when Num >= 100 -> {Num - 100, "C"};
determine_numeral(Num) when Num >= 90 -> {Num - 90, "XC"};
determine_numeral(Num) when Num >= 50 -> {Num - 50, "L"};
determine_numeral(Num) when Num >= 40 -> {Num - 40, "XL"};
determine_numeral(Num) when Num >= 10 -> {Num - 10, "X"};
determine_numeral(Num) when Num =:= 9 -> {0, "IX"};
determine_numeral(Num) when Num >= 5 -> {Num - 5, "V"};
determine_numeral(Num) when Num =:= 4 -> {0, "IV"};
determine_numeral(Num) -> {Num - 1, "I"}.

test_version() -> 1.
