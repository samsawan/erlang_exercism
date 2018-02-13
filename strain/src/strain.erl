-module(strain).

-export([keep/2, discard/2, test_version/0]).

keep(Fn, List) -> keep(Fn, List, []).


discard(Fn, List) -> discard(Fn, List, []).

test_version() -> 1.

keep(_, [], Acc) -> Acc;
keep(Fn, [H | T], Acc) ->
	case Fn(H) of
		true -> keep(Fn, T, Acc ++ [H]);
		false -> keep(Fn, T, Acc)
	end.

discard(_, [], Acc) -> Acc;
discard(Fn, [H | T], Acc) ->
	case Fn(H) of
		false -> discard(Fn, T, Acc ++ [H]);
		true -> discard(Fn, T, Acc)
	end.
