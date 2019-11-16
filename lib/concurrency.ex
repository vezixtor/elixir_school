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

  def process_linking do
    spawn(Concurrency, :explode, [])
  end

  def run_process_linking do
    Process.flag(:trap_exit, true)
    spawn_link(Concurrency, :explode, [])
    receive do
      {:EXIT, from_pid, reason} -> IO.puts("Exit reason: #{reason}, PID: #{inspect from_pid}")
    end
  end

  def explode, do: exit(:kaboom)

  def process_monitoring do
    {pid, ref} = spawn_monitor(Concurrency, :explode, [])
    receive do
      {:DOWN, ref, :process, from_pid, reason} -> IO.puts("Exit reason: #{reason}")
    end
  end
end
