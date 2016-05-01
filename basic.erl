% erlang

doubler() ->
  receive
    { From, N } ->
      io:format("doubler: got ~b~n", [N]),
      From ! { ok, N * 2 },
      doubler();
    stop ->
      io:format("doubler: stopping~n"),
      ok
  end.

counter(D, 10) ->
  D ! stop,
  ok;
counter(D, N) ->
  io:format("counter: sending ~b~n", [N]),
  D ! { self(), N },
  receive
    { ok, Reply } ->
      io:format("counter: got doubled - ~b~n", [Reply]),
      counter(D, N + 1)
  end.

main(_) ->
  io:format("main: starting~n"),
  D = spawn(fun() -> doubler() end),
  counter(D, 0),
  io:format("main: done~n").
