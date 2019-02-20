defmodule Rockpaperscissors.Channel do
  use GenServer
  alias Rockpaperscissors.User
  alias Rockpaperscissors.Vote
  @moduledoc false


  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def lookup(server, channel) do
    GenServer.call(server, {:lookup, channel})
  end

  def create(server, channel) do
    GenServer.cast(server, {:create, channel})
  end

  def vote(server, channel, user = %User{}) do
    {:ok, bucket} = lookup(server, channel)
    Vote.put(bucket, user.id, user)
  end

  def get_vote(server, channel, user = %User{}) do
    {:ok, bucket} = lookup(server, channel)
    Vote.get_vote(bucket, user.id)
  end

  def count(server, channel) do
    case lookup(server, channel) do
      {:ok, bucket} -> Vote.count(bucket)
      _ -> :error
    end
  end

  ## Server callbacks
  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:lookup, channel}, _from, channels) do
    {:reply, Map.fetch(channels, channel), channels}
  end

  def handle_cast({:create, channel}, channels) do
    if Map.has_key?(channels, channel) do
      {:noreply, channels}
    else
      {:ok, bucket} = Rockpaperscissors.Vote.start_link([])
      {:noreply, Map.put(channels, channel, bucket)}
    end
  end
end
