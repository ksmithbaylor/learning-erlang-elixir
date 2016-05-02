defmodule Counter do
  def server(10, parent) do
    IO.puts "server hit the limit"
    send parent, :done
  end
  def server(count, parent) do
    IO.puts "state: #{count}"
    receive do
      :inc -> server count+1, parent
    end
  end

  def client(id, server) do
    :rand.uniform * 1000 |> trunc |> :timer.sleep
    send server, :inc
    client id, server
  end

  def start_clients(0, _, clients), do: clients
  def start_clients(n, server, clients) do
    client = spawn fn -> client(n, server) end
    IO.puts "spawned client #{inspect client}"
    start_clients n-1, server, clients ++ [client]
  end

  def kill_clients([]), do: :ok
  def kill_clients([client|clients]) do
    IO.puts "killing client #{inspect client}"
    Process.exit client, :kill
    kill_clients clients
  end
end

parent = self
server = spawn fn -> Counter.server(0, parent) end
clients = Counter.start_clients 3, server, []
receive do
  :done ->
    Counter.kill_clients clients
    IO.puts "all done!"
end
