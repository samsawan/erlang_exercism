-module(word_count).

-export([count/1, test_version/0]).

count(String) ->
  DiscreteWords = split(String),
  dict:from_list(count_discrete_words(DiscreteWords)).

test_version() -> 1.

split(String) ->
	element(2,
		lists:foldr(
			fun(Char, {ContructedWord, WordList}) ->
				case is_valid_char(Char) of
					true -> {[Char | ContructedWord], WordList};
					false -> {"", add_constructed_word(ContructedWord, WordList)}
				end
			end,
			{"", []},
			[$,|String]
		)
	).

count_discrete_words(DiscreteWords) ->
	lists:foldl(
		fun(Word, WordCounts) ->
			LowerCaseWord = string:to_lower(Word),
		 	NewValue = proplists:get_value(LowerCaseWord, WordCounts, 0) + 1,
		 	lists:keystore(LowerCaseWord, 1, WordCounts, {LowerCaseWord, NewValue})
		end,
		[],
		DiscreteWords
	).

is_valid_char(Char) ->
	is_digit(Char) orelse is_lowercase_letter(Char) orelse is_uppercase_letter(Char).

is_digit(Char) -> Char >= $0 andalso Char =< $9.
is_lowercase_letter(Char) -> Char >= $a andalso Char =< $z.
is_uppercase_letter(Char) -> Char >= $A andalso Char =< $Z.

add_constructed_word("", WordList) -> WordList;
add_constructed_word(ContructedWord, WordList) -> [ContructedWord | WordList].
