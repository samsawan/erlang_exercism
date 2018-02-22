-module(atbash_cipher).

-export([encode/1, decode/1, test_version/0]).

-define(alphabet, "abcdefghijklmnopqrstuvwxyz").
-define(reverse_alphabet, "zyxwvutsrqponmlkjihgfedcba").
-define(space, $ ).

encode(String) ->
	{EncodedPhrase, _} =
		lists:foldl(
		fun(Letter, {EncodedString, Count}) ->
			EncodedChar = lists:nth(determine_index(Letter, ?alphabet), ?reverse_alphabet),
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
  undefined.

test_version() -> 1.

determine_index(Member, Seq) -> determine_index(Member, Seq, 1).

determine_index(Member, [Member | _], Index) -> Index;
determine_index(Member, [_| T], Index) -> determine_index(Member, T, Index + 1).

sanitize(String) ->
	lists:filter(
		fun(Char) -> lists:member(Char, ?alphabet) end,
		string:to_lower(String)
	).
