-module(atbash_cipher).

-export([encode/1, decode/1, test_version/0]).

-define(alphabet, "abcdefghijklmnopqrstuvwxyz123456789").
-define(reverse_alphabet, "zyxwvutsrqponmlkjihgfedcba123456789").
-define(space, $ ).

encode(String) ->
	IndexFunc = fun(C) -> fun() -> determine_index(C, ?alphabet) end end,
	{EncodedPhrase, _} =
	lists:foldl(
		fun(Char, {EncodedString, Count}) ->
			EncodedChar = cipher(IndexFunc(Char), ?reverse_alphabet),
			case Count of
				5 -> {EncodedString ++ [?space, EncodedChar], 1};
				_ -> {EncodedString ++ [EncodedChar], Count + 1}
			end
		end,
		{[], 0},
		sanitize(String)
	),
	unicode:characters_to_list(EncodedPhrase).

decode(String) ->
	IndexFunc = fun(C) -> fun() -> determine_index(C, ?reverse_alphabet) end end,
  DecodedPhrase =
  lists:foldl(
  	fun(Char, DecodedString) ->
			DecodedChar = cipher(IndexFunc(Char), ?alphabet),
  		DecodedString ++ [DecodedChar]
  	end,
  	[],
  	sanitize(String)
	),
	unicode:characters_to_list(DecodedPhrase).

test_version() -> 1.

determine_index(Member, Seq) -> determine_index(Member, Seq, 1).

determine_index(Member, [Member | _], Index) -> Index;
determine_index(Member, [_| T], Index) -> determine_index(Member, T, Index + 1).

sanitize(String) ->
	lists:filter(
		fun(Char) -> lists:member(Char, ?alphabet) end,
		string:to_lower(String)
	).

cipher(DetermineIndexFunc, Legend) -> lists:nth(DetermineIndexFunc(), Legend).
