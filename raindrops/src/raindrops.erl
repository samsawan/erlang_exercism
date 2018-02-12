-module(raindrops).

-export([convert/1, test_version/0]).

-define(TRANSLATIONS, #{3 => "Pling", 5 => "Plang", 7 => "Plong"}).
-define(EMPTY_TRANSLATION, "").

convert(Number) ->
	FactorsToConsider =
	[
			translate_number(3, Number),
			translate_number(5, Number),
			translate_number(7, Number)
	],
	PartialTransform = lists:foldl(fun add_phrase/2, ?EMPTY_TRANSLATION, FactorsToConsider),
	case PartialTransform of
		?EMPTY_TRANSLATION -> integer_to_list(Number);
		_ -> PartialTransform
	end.

test_version() -> 1.

add_phrase({true = _WasFactor, Phrase}, Translation) -> string:concat(Translation, Phrase);
add_phrase({false = _WasFactor, _}, Translation) -> Translation.

translate_number(Factor, Number) when Number rem Factor =:= 0 -> {true, maps:get(Factor, ?TRANSLATIONS)};
translate_number(_, _) -> {false, dne}.
