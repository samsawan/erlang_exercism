-module(robot_simulator).

-behavior(gen_server).

-export([advance/1, control/2, create/0, direction/1, left/1, right/1, place/3, position/1, test_version/0]).
-export([init/1, code_change/3, handle_call/3, handle_cast/2, handle_info/2, terminate/1]).

-record(state, {direction, position = {undefined, undefined}}).

-define(left_directions, [north, west, south, east]).
-define(right_directions, [north, east, south, west]).

% api

advance(Robot) -> gen_server:cast(Robot, advance).

control(Robot, "unknown") -> ok;
control(Robot, String) -> lists:foreach(fun(Cmd) -> execute_command(Robot, Cmd) end, String).

create() -> element(2, gen_server:start_link(?MODULE, [], [])).

direction(Robot) -> gen_server:call(Robot, direction).

position(Robot) -> gen_server:call(Robot, position).

left(Robot) -> gen_server:cast(Robot, left).

right(Robot) -> gen_server:cast(Robot, right).

place(Robot, Direction, Position) -> gen_server:cast(Robot, {place, Direction, Position}).

test_version() -> 1.

execute_command(Robot, $R) -> right(Robot);
execute_command(Robot, $L) -> left(Robot);
execute_command(Robot, $A) -> advance(Robot).


% gen_server callbacks

init(_) -> {ok, #state{}}.

handle_call(direction, _, State) ->
	{reply, State#state.direction, State};
handle_call(position, _, State) ->
	{reply, State#state.position, State}.

handle_cast({place, Direction, Position}, _) ->
	{noreply, #state{direction = Direction, position = Position}};
handle_cast(left, #state{direction = PreviousDirection} = State) ->
	{noreply, State#state{direction = determine_direction(left, ?left_directions, PreviousDirection)}};
handle_cast(right, #state{direction = PreviousDirection} = State) ->
	{noreply, State#state{direction = determine_direction(right, ?right_directions, PreviousDirection)}};
handle_cast(advance, #state{direction = Direction, position = Position}) ->
	{noreply, #state{direction = Direction, position = move(Direction, Position)}}.

handle_info(_, _) -> undefined.

code_change(_, _, _) -> undefined.

terminate(_) -> ok.

% internal gen server functions

determine_direction(left, [_D|[]], _D) -> hd(?left_directions);
determine_direction(right, [_D|[]], _D) -> hd(?right_directions);
determine_direction(_, [_D|T], _D) -> hd(T);
determine_direction(Dir, [_|T], D) -> determine_direction(Dir, T, D).

move(north, {XCoor, YCoor}) -> {XCoor, YCoor + 1};
move(south, {XCoor, YCoor}) -> {XCoor, YCoor - 1};
move(east, {XCoor, YCoor}) -> {XCoor + 1, YCoor};
move(west, {XCoor, YCoor}) -> {XCoor - 1, YCoor}.

