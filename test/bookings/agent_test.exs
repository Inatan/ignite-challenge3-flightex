defmodule Flightex.Bookings.AgentTest do
  use ExUnit.Case

  import FlightexTest.Factory

  alias Flightex.Bookings.Booking
  alias Flightex.Bookings.Agent, as: BookingAgent

  describe "save/1" do
    test "save the booking" do
      booking = build(:booking)

      BookingAgent.start_link(%{})

      assert {:ok, _id} = BookingAgent.save(booking)
    end
  end

  describe "get/1" do
    setup do
      booking = build(:booking)

      BookingAgent.start_link(%{})

      {:ok, %{booking: booking}}
    end

    test "get the booking", %{booking: booking} do
      {:ok, id} = BookingAgent.save(booking)

      assert {:ok, _booking} = BookingAgent.get(id)
    end

    test "booking doesn't exists" do
      assert {:error, _reason} = BookingAgent.get("banana")
    end
  end
end
