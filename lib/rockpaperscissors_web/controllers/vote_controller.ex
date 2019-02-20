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
    :ok = Rockpaperscissors.Channel.create(Rockpaperscissors.Channel, channel)

    render(conn, "init.json", %{"channel" => channel})
  end

  @doc """
  Count the result of a channel
  """
  def count(conn, %{"channel" => channel}) do
    case Rockpaperscissors.Channel.count(Rockpaperscissors.Channel, channel) do
      :error ->
        conn |> put_status(:not_found) |> render("404.json")
      count ->
        render(conn, "count.json", %{"channel" => channel, "count" => count})
    end
  end
end
