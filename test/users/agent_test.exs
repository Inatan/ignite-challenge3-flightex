defmodule Flightex.Users.AgentTest do
  use ExUnit.Case

  import FlightexTest.Factory

  alias Flightex.Users.User
  alias Flightex.Users.Agent, as: UserAgent

  describe "save/1" do
    test "save the user" do
      user = build(:user)

      UserAgent.start_link(%{})

      assert {:ok, _id} = UserAgent.save(user)
    end
  end

  describe "get/1" do
    setup do
      user = build(:user)

      UserAgent.start_link(%{})

      {:ok, %{user: user}}
    end

    test "get the user", %{user: user} do
      {:ok, id} = UserAgent.save(user)

      assert {:ok, _user} = UserAgent.get(id)
    end

    test "user doesn't exists" do
      assert {:error, _reason} = UserAgent.get("banana")
    end
  end
end
