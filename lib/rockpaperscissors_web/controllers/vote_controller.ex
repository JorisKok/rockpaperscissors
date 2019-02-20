defmodule RockpaperscissorsWeb.VoteController do
  use RockpaperscissorsWeb, :controller
  @moduledoc """
  Initiate a rock paper scissors session for x seconds
  Where players can cast their choice
  And the result will be displayed in the twitch channel
  """

  @doc """
  Start a rock paper scissors session
  """

  def init(conn, %{"channel" => channel}) do
    # TODO create a channel

    render(conn, "init.json", %{"channel" => channel})
  end
end
