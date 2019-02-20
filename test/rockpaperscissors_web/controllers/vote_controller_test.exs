defmodule RockpaperscissorsWeb.VoteControllerTest do
  use RockpaperscissorsWeb.ConnCase, async: true
  import AssertValue

  describe "We can start a voting session that lasts for x seconds in which users can vote" do
    test "We can start a voting session for a channel name and get an id back", %{conn: conn} do
        conn = post conn, "/v1/vote", %{channel: "test"}

        assert_value json_response(conn, 200) == %{
                       "data" => %{"channel" => "test"},
                       "message" => "Initiated session",
                       "success" => true
                     }
    end
  end
end
