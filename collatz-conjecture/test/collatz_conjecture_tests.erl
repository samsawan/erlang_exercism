-module(collatz_conjecture_tests).

% This file is automatically generated from the exercises canonical data.

-include_lib("erl_exercism/include/exercism.hrl").
-include_lib("eunit/include/eunit.hrl").


zero_steps_for_one_test() ->
    ?assertMatch(0, collatz_conjecture:steps(1)).

divide_if_even_test() ->
    ?assertMatch(4, collatz_conjecture:steps(16)).

even_and_odd_steps_test() ->
    ?assertMatch(9, collatz_conjecture:steps(12)).

large_number_of_even_and_odd_steps_test() ->
    ?assertMatch(152, collatz_conjecture:steps(1000000)).

zero_is_an_error_test() ->
    ?assertMatch({error,
		  "Only positive numbers are allowed"},
		 collatz_conjecture:steps(0)).

negative_value_is_an_error_test() ->
    ?assertMatch({error,
		  "Only positive numbers are allowed"},
		 collatz_conjecture:steps(-15)).

version_test() ->
    ?assertMatch(2, collatz_conjecture:test_version()).
