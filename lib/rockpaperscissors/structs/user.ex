defmodule Rockpaperscissors.User do
  alias Rockpaperscissors.User
  @moduledoc false
  defstruct [:id, :username, :display_name, :vote]

  def voted_rock?(user = %User{}) do
    user.vote == "rock"
  end

  def voted_paper?(user = %User{}) do
    user.vote == "paper"
  end

  def voted_scissors?(user = %User{}) do
    user.vote == "scissors"
  end
end
