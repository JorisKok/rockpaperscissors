defmodule Rockpaperscissors.ChannelTest do
  use RockpaperscissorsWeb.ConnCase, async: true
  import AssertValue
  alias Rockpaperscissors.User

  setup do
    registry = start_supervised!(Rockpaperscissors.Channel)
    %{registry: registry}
  end

  describe "We can start a session for a channel, and vote on it" do
    test "We can start a channel", %{registry: registry} do
      Rockpaperscissors.Channel.create(registry, "awesome-user-channel")
      assert {:ok, bucket} = Rockpaperscissors.Channel.lookup(registry, "awesome-user-channel")
    end

    test "We can vote on a started channel", %{registry: registry} do
      Rockpaperscissors.Channel.create(registry, "awesome-user-channel")

      user = %User{
        id: "9f4fa4c5-32f4-4fc3-ad81-91c4d09025d2",
        username: "user x",
        display_name: "user X",
        vote: "paper"
      }
      Rockpaperscissors.Channel.vote(registry, "awesome-user-channel", user) == :ok

      assert_value Rockpaperscissors.Channel.get_vote(registry, "awesome-user-channel", user) ==
                     "paper"
    end

    @tag :current
    test "We can count all votes", %{registry: registry} do
      Rockpaperscissors.Channel.create(registry, "awesome-user-channel")

      user = %User{
        id: "9f4fa4c5-32f4-4fc3-ad81-91c4d09025d2",
        username: "user p",
        display_name: "user P",
        vote: "paper"
      }
      Rockpaperscissors.Channel.vote(registry, "awesome-user-channel", user) == :ok

      user = %User{
        id: "9f4fa4c5-32f4-4555-ad81-91c4d09025d2",
        username: "user r",
        display_name: "user R",
        vote: "rock"
      }
      Rockpaperscissors.Channel.vote(registry, "awesome-user-channel", user) == :ok

      user = %User{
        id: "9f4fa666-32f4-4555-ad81-91c4d09025d2",
        username: "user rr",
        display_name: "user RR",
        vote: "rock"
      }
      Rockpaperscissors.Channel.vote(registry, "awesome-user-channel", user) == :ok

      user = %User{
        id: "9111a666-sssS-4555-ad81-91c4d09025d2",
        username: "user s",
        display_name: "user S",
        vote: "scissors"
      }
      Rockpaperscissors.Channel.vote(registry, "awesome-user-channel", user) == :ok

      assert_value Rockpaperscissors.Channel.count(registry, "awesome-user-channel") == %{
                     "paper" => 1,
                     "rock" => 2,
                     "scissors" => 1
                   }
    end

    # TODO test no duplicate users
    # TODO valid vote

    # TODO test that we can destroy channel and all it's votes

    # TODO make some timer event?
  end
end
