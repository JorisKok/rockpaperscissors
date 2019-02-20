defmodule Rockpaperscissors.VoteTest do
  use ExUnit.Case, async: true
  alias Rockpaperscissors.User
  import AssertValue

  describe "Storing votes" do
    test "Store votes" do
      user = %User{id: "9f4fa4c5-32f4-4fc3-ad81-91c4d09025d2", username: "User x", display_name: "User X", vote: "rock"}

      {:ok, bucket} = Rockpaperscissors.Vote.start_link([])
      assert_value Rockpaperscissors.Vote.get_vote(bucket, user.id) == nil

      Rockpaperscissors.Vote.put(bucket, user.id, user)
      assert_value Rockpaperscissors.Vote.get_vote(bucket, user.id) == "rock"
    end

    test "Store votes can return the whole user object" do
      user = %User{id: "9f4fa4c5-32f4-4fc3-ad81-91c4d09025d2", username: "User x", display_name: "User X", vote: "rock"}

      {:ok, bucket} = Rockpaperscissors.Vote.start_link([])
      assert_value Rockpaperscissors.Vote.get(bucket, user.id) == nil

      Rockpaperscissors.Vote.put(bucket, user.id, user)
      assert_value Rockpaperscissors.Vote.get(bucket, user.id) == %Rockpaperscissors.User{
                     display_name: "User X",
                     id: "9f4fa4c5-32f4-4fc3-ad81-91c4d09025d2",
                     username: "User x",
                     vote: "rock"
                   }
    end

  end
end

