defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  # filename \\ "report.csv"
  def generate_report(from_date, to_date) do
    booking_list = build_booking_list(from_date, to_date)

    filename = "#{Date.to_string(from_date)}-#{Date.to_string(to_date)}.csv"

    File.write(filename, booking_list)

    {:ok, "Report generated successfully"}
  end

  defp build_booking_list(from_date, to_date) do
    BookingAgent.get_all()
    |> Map.values()
    |> Enum.filter(fn x ->
      NaiveDateTime.compare(x.data_completa, from_date) == :gt and
        NaiveDateTime.compare(x.data_completa, to_date) == :lt
    end)
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
