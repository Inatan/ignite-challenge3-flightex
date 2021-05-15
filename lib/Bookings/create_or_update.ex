defmodule Flightex.Bookings.CreateOrUpdate do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Bookings.Booking

  def call(%{
        data_completa: data_completa,
        cidade_origem: cidade_origem,
        cidade_destino: cidade_destino,
        id_usuario: id_usuario
      }) do
    with {:ok, user} <- UserAgent.get(id_usuario),
         {:ok, booking} <- Booking.build(data_completa, cidade_origem, cidade_destino, id_usuario) do
      BookingAgent.save(booking)
    else
      error -> error
    end
  end
end
