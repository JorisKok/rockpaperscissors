defmodule RockpaperscissorsWeb.VoteView do
  use RockpaperscissorsWeb, :view
  @moduledoc false

  def render("init.json", %{"channel" => channel})  do
    %{
      success: true,
      message: "Initiated session",
      data: %{
        channel: channel
      }
    }
  end

  def render("count.json", %{"channel" => channel, "count" => count}) do
    %{
      success: true,
      message: "Counted the votes",
      data: %{
        channel: channel,
        count: count
      }
    }
  end

  # TODO move to error_view
  def render("404.json", _assigns) do
    %{errors: %{detail: "Not found"}}
  end
end
