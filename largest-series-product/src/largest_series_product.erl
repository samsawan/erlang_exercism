-module(largest_series_product).

-export([lsp/2, test_version/0]).

lsp(_, Span) when Span < 0 -> error;
lsp("", 0)  -> 1;
lsp(_, 0)  -> 1;
lsp("", _)  -> error;
lsp(String, N) when N > length(String) -> error;
lsp(String, N) -> calculate_highest_product(0, validate(String), N).

validate(String) ->
	case contains_only_numbers(String) of
		true -> String;
		false -> error
	end.

calculate_highest_product(_, error, _) -> error;
calculate_highest_product(Product, String, N) when length(String) < N -> Product;
calculate_highest_product(Product, [_ | RemNums] = NumString, N) ->
	NewProduct = calculate_higher_product(string:sub_string(NumString, 1, N), Product),
	calculate_highest_product(NewProduct, RemNums, N).

calculate_higher_product(NewNums, PrevProd) ->
	NewProd = lists:foldl(fun(NumString, Acc) -> Acc * (NumString - 48) end, 1, NewNums),
	case NewProd > PrevProd of
		true -> NewProd;
		false -> PrevProd
	end.

contains_only_numbers(String) ->
	not
	lists:any(fun(Char) when Char < $0 orelse Char > $9 -> true;
							 (_) -> false
						end,
						String).

test_version() -> 1.
