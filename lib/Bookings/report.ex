defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def create(filename \\ "report.csv") do
    booking_list = build_booking_list()

    File.write(filename, booking_list)

    {:ok, "Report generated successfully"}
  end

  defp build_booking_list do
    BookingAgent.get_all()
    |> Map.values()
    |> Enum.map(fn booking -> booking_string(booking) end)
  end

  defp booking_string(%Booking{
         data_completa: data_completa,
         cidade_origem: cidade_origem,
         cidade_destino: cidade_destino,
         id_usuario: id_usuario
       }) do
    "#{id_usuario},#{cidade_origem},#{cidade_destino},#{data_completa}\n"
  end
end
