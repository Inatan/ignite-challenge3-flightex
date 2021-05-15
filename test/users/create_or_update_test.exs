defmodule Flightex.Users.CreateOrUpdateTest do
  use ExUnit.Case

  import FlightexTest.Factory

  alias Flightex.Users.User

  describe "call/3" do
    test "save the user" do
      params = %{
        cpf: "12312312354",
        email: "ina@ina.com",
        name: "Ina"
      }

      Flightex.start_agents()

      assert {:ok, _id} = Flightex.create_or_update_user(params)
    end
  end
end
