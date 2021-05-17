defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case

  import FlightexTest.Factory

  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Report

  describe "create/1" do
    test "create the report file" do
      BookingAgent.start_link(%{})
      idUser = UUID.uuid4()
      booking1 = build(:booking, id_usuario: idUser, id: "1")
      BookingAgent.save(booking1)

      booking2 =
        build(:booking, id_usuario: idUser, data_completa: ~N[2010-01-01 22:00:07], id: "2")

      BookingAgent.save(booking2)

      booking3 =
        build(:booking, id_usuario: idUser, data_completa: ~N[2012-01-01 22:00:07], id: "3")

      BookingAgent.save(booking3)

      expected_response = {:ok, "#{idUser},Porto Alegre,Curicica,2010-01-01 22:00:07\n"}

      Report.generate_report(~N[2010-01-01 00:00:07], ~N[2011-01-01 23:00:07])

      response = File.read("2010-01-01-2011-01-01.csv")

      assert response == expected_response
    end
  end
end
