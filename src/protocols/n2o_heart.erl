-module(n2o_heart).
-author('Maxim Sokhatsky').
-include_lib("n2o/include/wf.hrl").
-compile(export_all).

info({text,<<"PING">> = Ping}=Message, Req, State) ->
    wf:info(?MODULE,"PING: ~p",[Message]),
    {reply, wf:json([]), Req, State};
info({text,<<"N2O,",Process/binary>> = InitMarker}=Message, Req, State) ->
    wf:info(?MODULE,"N2O INIT: ~p",[Message]),
    n2o_websocket:push({init,Process},Req,State,n2o_websocket:protocols(),[]);

info(Message, Req, State) -> {unknown,Message, Req, State}.
