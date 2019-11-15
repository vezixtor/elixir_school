defmodule Concurrency do

  def message_passing do
    pid = spawn(Concurrency, :listen, [])
    IO.inspect(pid)
    send(pid, {:ok, "hello"})
    send(pid, :ok)
    send(pid, :ok)
    send(pid, :ok)
    send(pid, :ok)
    send(pid, :ok)
    :timer.sleep(1000)
    send(pid, {:ok, "hello"})
    send(pid, {:ok, "return last statement"})
  end

  def listen do
    IO.inspect(Time.utc_now)
    receive do
      {:ok, "hello"} -> IO.puts("Hello Listen")
    end
    listen()
  end
end
