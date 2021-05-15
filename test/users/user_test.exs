defmodule Flightex.Users.UserTest do
  use ExUnit.Case

  import FlightexTest.Factory

  alias Flightex.Users.User

  describe "build/3" do
    test "returns the user" do
      {:ok,response} = User.build("Ina", "ina@ina.com", "12312312354")

      expected_response = build(:user,id: response.id)

      assert response == expected_response
    end
  end
end
