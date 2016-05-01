defmodule Basic do
  def doubler() do
    receive do
      { from, n } ->
        IO.puts "doubler: got #{n}"
        send from, { :ok, n * 2 }
        doubler
      :stop ->
        IO.puts "doubler: stopping"
        :ok
    end
  end

  def counter(d, 10) do
    send d, :stop
    :ok
  end
  def counter(d, n) do
    IO.puts "counter: sending #{n}"
    send d, { self, n }
    receive do
      { :ok, reply } ->
        IO.puts "counter: got doubled - #{reply}"
        counter(d, n + 1)
    end
  end
end

IO.puts "main: starting"
d = spawn Basic, :doubler, []
Basic.counter(d, 0)
IO.puts "main: done"
