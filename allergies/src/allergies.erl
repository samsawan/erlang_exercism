-module(allergies).

-export([allergies/1, is_allergic_to/2, test_version/0]).

-define(KEY, [cats, pollen, chocolate, tomatoes, strawberries, shellfish, peanuts, eggs]).

allergies(Score) ->
	BaseTwo = string:right(integer_to_list(Score, 2), 8, $0),
	FinalKey = lists:zip(BaseTwo, ?KEY),
	ValidatorFunc =
	fun({$1, Value}, Acc) -> [Value | Acc];
		 ({$0, _}, Acc) -> Acc end,
	lists:foldl(ValidatorFunc, [], FinalKey).

is_allergic_to(PotentialAllergy, Score) -> lists:member(PotentialAllergy, allergies(Score)).

test_version() -> 1.

