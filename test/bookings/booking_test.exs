defmodule Flightex.Bookings.BookingTest do
  use ExUnit.Case

  import FlightexTest.Factory

  alias Flightex.Bookings.Booking
  alias Flightex.Users.Agent, as: UserAgent

  describe "build/4" do
    test "build a booking" do
      id_user = UUID.uuid4()

      {:ok, response} =
        Booking.build(
          NaiveDateTime.from_iso8601("2000-01-01 23:00:07"),
          "Porto Alegre",
          "Curicica",
          id_user
        )

      expected_response = build(:booking, id: response.id, id_usuario: id_user)

      assert response == expected_response
    end

    test "build fail when not given a date" do
      id_user = UUID.uuid4()

      response =
        Booking.build(
          NaiveDateTime.from_iso8601("aaaa"),
          "Porto Alegre",
          "Curicica",
          id_user
        )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
