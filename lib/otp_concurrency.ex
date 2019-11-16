defmodule OtpConcurrency do
  use GenServer

  def init(state), do: {:ok, state}

  def start_link(state \\ []) do
    inspecting = GenServer.start_link(__MODULE__, state, name: __MODULE__)
    IO.inspect(inspecting)
  end

  def handle_call(:dequeue, _from, [value | state]) do
    {:reply, value, state}
  end

  def handle_call(:dequeue, _from, []), do: {:reply, nil, []}

  def handle_call(:queue, _from, state), do: {:reply, state, state}

  def queue, do: GenServer.call(__MODULE__, :queue)

  def dequeue, do: GenServer.call(__MODULE__, :dequeue)
end