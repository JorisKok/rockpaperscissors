defmodule Rockpaperscissors.Channel do
  use GenServer
  alias Rockpaperscissors.User
  alias Rockpaperscissors.Vote
  @moduledoc false


  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def lookup(server, name) do
    GenServer.call(server, {:lookup, name})
  end

  def create(server, name) do
    GenServer.cast(server, {:create, name})
  end

  def vote(server, name, user = %User{}) do
    {:ok, bucket} = lookup(server, name)
    Vote.put(bucket, user.id, user)
  end

  def get_vote(server, name, user = %User{}) do
    {:ok, bucket} = lookup(server, name)
    Vote.get_vote(bucket, user.id)
  end

  def count(server, name) do
    {:ok, bucket} = lookup(server, name)
    Vote.count(bucket)
  end

  ## Server callbacks
  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:lookup, name}, _from, names) do
    {:reply, Map.fetch(names, name), names}
  end

  def handle_cast({:create, name}, names) do
    if Map.has_key?(names, name) do
      {:noreply, names}
    else
      {:ok, bucket} = Rockpaperscissors.Vote.start_link([])
      {:noreply, Map.put(names, name, bucket)}
    end
  end
end
