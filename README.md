# Fun with the BEAM

Just some playing around with erlang and elixir. I implemented the same programs in both to get a feel for both languages and how they relate.

To run an erlang program:

    $ escript <ANY>.erl

To run an elixir program:

    $ elixir <ANY>.exs

# `basic.{erl,exs}`

The main process spawns a process with no state that receives a number and replies with its double. The main process then sends the numbers 0-9 to the process. When the numbers have been sent, the main process stops the "doubler" process, and the program exits.

# `counter.{erl,exs}`

The main process spawns one process as a "server" that holds a number, and 10 "clients". Each client sends "`inc`" commands to the server at random intervals to increment the number it holds. Once the number reaches 10, the server stops itself and tells the main process that it is done. When this happens, the main process kills all the clients, and the program exits.
