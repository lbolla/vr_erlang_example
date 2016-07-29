%%%-------------------------------------------------------------------
%% @doc vr_erlang_example public API
%% @end
%%%-------------------------------------------------------------------

-module(vr_erlang_example_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
                                      {'_', [{"/", hello_handler, []}]}
                                     ]),
    {ok, _} = cowboy:start_clear(http, 100, [{port, 8080}], #{
                                              env => #{dispatch => Dispatch}
                                             }),
    vr_erlang_example_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
