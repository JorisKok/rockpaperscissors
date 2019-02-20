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

    test "We can count the voting results for a channel name", %{conn: conn} do
      post conn, "/v1/vote", %{channel: "test"}

      conn = get conn, "/v1/vote/test/count"

      assert_value json_response(conn, 200) == %{
                     "data" => %{
                       "channel" => "test",
                       "count" => %{"paper" => 0, "rock" => 0, "scissors" => 0}
                     },
                     "message" => "Counted the votes",
                     "success" => true
                   }
    end

    test "We return a 404 when a channel is not found", %{conn: conn} do
      conn = get conn, "/v1/vote/test/count"

      assert_value json_response(conn, 404) == %{"errors" => %{"detail" => "Not found"}}
    end

  end
end
