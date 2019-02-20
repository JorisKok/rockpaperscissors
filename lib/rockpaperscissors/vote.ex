defmodule Rockpaperscissors.Vote do
  use Agent
  alias Rockpaperscissors.User
  import Rockpaperscissors.Helpers

  @doc """
  Starts a new bucket.
  """
  def start_link(_opts) do
    Agent.start_link(fn -> %{} end)
  end

  @doc """
  Get the whole user
  """
  def get(bucket, user_id) do
    Agent.get(bucket, &Map.get(&1, user_id))
  end

  @doc """
  Count the rock, paper, scissor votes
  """
  def count(bucket) do
    %{
      "rock" => Agent.get(bucket, fn values -> Enum.reduce(values, 0, fn {_id, user}, acc -> boolean_to_integer(User.voted_rock?(user)) + acc end) end),
      "paper" => Agent.get(bucket, fn values -> Enum.reduce(values, 0, fn {_id, user}, acc -> boolean_to_integer(User.voted_paper?(user)) + acc end) end),
      "scissors" => Agent.get(bucket, fn values -> Enum.reduce(values, 0, fn {_id, user}, acc -> boolean_to_integer(User.voted_scissors?(user)) + acc end) end),
    }
  end

  @doc """
  Get the vote only
  """
  def get_vote(bucket, user_id) do
    case Agent.get(bucket, &Map.get(&1, user_id)) do
      user = %User{} -> user.vote
      _ -> nil
    end
  end


  @doc """
  Puts the `value` for the given `user_id` in the `bucket`.
  """
  def put(bucket, user_id, value) do
    Agent.update(bucket, &Map.put(&1, user_id, value))
  end

end

