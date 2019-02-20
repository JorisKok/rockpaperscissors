defmodule RockpaperscissorsWeb.VoteView do
  use RockpaperscissorsWeb, :view
  @moduledoc false

  def render("init.json", %{"channel" => channel})  do
    %{
      success: true,
      message: "Initiated session",
      data:
      %{
        channel: channel
      }
    }
  end
end
