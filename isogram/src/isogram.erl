-module(isogram).

-export([is_isogram/1, test_version/0]).

-define(HYPHEN, $-).
-define(SPACE, $\ ).

is_isogram(String) ->
    {IsIsogram, _} =
    lists:foldl(
    	fun(Char, {false, _}) ->
				{false, []};
  		 (Char, {true, PreviousChars}) ->
  		 	case Char =:= ?HYPHEN orelse Char =:= ?SPACE orelse not lists:member(Char, PreviousChars) of
  		 		true -> {true, [Char | PreviousChars]};
  		 		false -> {false, []}
  		 	end
    	end,
    	{true, []},
    	string:to_lower(String)
    ),
    IsIsogram.

test_version() ->
    1.
