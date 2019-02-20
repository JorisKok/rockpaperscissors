defmodule RockpaperscissorsWeb.Router do
  use RockpaperscissorsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/v1", RockpaperscissorsWeb do
    pipe_through :api

    post "/vote", VoteController, :init
    get "/vote/:channel/count", VoteController, :count
  end
end
