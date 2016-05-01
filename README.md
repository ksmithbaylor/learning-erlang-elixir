Just some playing around with erlang and elixir. I implemented the same program
in both to get a feel for both languages.

The program spins up a process that receives a number and replies with that
number doubled. It then sends the numbers 0-9 to the process, after which it
shuts the process down and then terminates.

To run the erlang program:

    $ escript basic.erl

To run the elixir program:

    $ elixir basic.exs
