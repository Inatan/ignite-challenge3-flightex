defmodule Flightex.Bookings.CreateOrUpdateTest do
  use ExUnit.Case

  import FlightexTest.Factory

  alias Flightex.Bookings.Booking
  alias Flightex.Bookings.CreateOrUpdate
  alias Flightex.Users.Agent, as: UserAgent

  describe "call/3" do
    setup do
      user = build(:user)

      Flightex.start_agents()

      {:ok, user_id} = UserAgent.save(user)

      {:ok, %{user_id: user_id}}
    end

    test "save the booking", %{user_id: user_id} do
      params = %{
        data_completa: NaiveDateTime.from_iso8601("2000-01-01 23:00:07"),
        cidade_origem: "Porto Alegre",
        cidade_destino: "Curicica",
        id_usuario: user_id
      }

      response = Flightex.create_or_update_booking(params)

      assert {:ok, _id} = response
    end

    test "when try to save a booking when date is invalid returns error", %{user_id: user_id} do
      params = %{
        data_completa: NaiveDateTime.from_iso8601("bBa"),
        cidade_origem: "Porto Alegre",
        cidade_destino: "Curicica",
        id_usuario: user_id
      }

      response = Flightex.create_or_update_booking(params)

      assert response == {:error, "Invalid parameters"}
    end

    test "when try to save a booking when user doesn't exists returns error", %{user_id: user_id} do
      params = %{
        data_completa: NaiveDateTime.from_iso8601("2000-01-01 23:00:07"),
        cidade_origem: "Porto Alegre",
        cidade_destino: "Curicica",
        id_usuario: "Banana"
      }

      response = Flightex.create_or_update_booking(params)

      assert response == {:error, "User not found"}
    end
  end
end
