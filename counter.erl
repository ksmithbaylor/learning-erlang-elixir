% erlang

server(10, Parent) ->
  io:format("server hit the limit~n"),
  Parent ! done;
server(Count, Parent) ->
  io:format("state: ~b~n", [Count]),
  receive
    inc -> server(Count+1, Parent)
  end.

client(Id, Server) ->
  timer:sleep(trunc(rand:uniform() * 1000)),
  Server ! inc,
  client(Id, Server).

start_clients(0, _, Clients) -> Clients;
start_clients(N, Server, Clients) ->
  Client = spawn(fun() -> client(N, Server) end),
  io:format("spawned client ~p~n", [Client]),
  start_clients(N-1, Server, lists:append(Clients, [Client])).

kill_clients([]) -> ok;
kill_clients([Client|Clients]) ->
  io:format("killing client ~p~n", [Client]),
  exit(Client, done),
  kill_clients(Clients).

main(_) ->
  Parent = self(),
  Server = spawn(fun() -> server(0, Parent) end),
  Clients = start_clients(3, Server, []),
  receive
    done ->
      kill_clients(Clients),
      io:format("all done!~n")
  end.
