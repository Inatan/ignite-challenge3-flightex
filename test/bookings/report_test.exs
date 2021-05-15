defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case

  import FlightexTest.Factory

  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Report

  describe "create/1" do
    test "create the report file" do
      BookingAgent.start_link(%{})

      booking1 = build(:booking)
      BookingAgent.save(booking1)

      expected_response =
        {:ok, "#{booking1.id},2000-01-01 23:00:07,Porto Alegre,Curicica,#{booking1.id_usuario}\n"}

      Report.create("Report_test.csv")

      response = File.read("Report_test.csv")

      assert response == expected_response
    end
  end
end
