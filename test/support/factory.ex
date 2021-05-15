defmodule FlightexTest.Factory do
  use ExMachina

  alias Flightex.Users.User
  alias Flightex.Bookings.Booking

  def user_factory do
    %User{
      id: UUID.uuid4(),
      name: "Ina",
      email: "ina@ina.com",
      cpf: "12312312354"
    }
  end

  def booking_factory do
    %Booking{
      id: UUID.uuid4(),
      data_completa: ~N[2000-01-01 23:00:07],
      cidade_origem: "Porto Alegre",
      cidade_destino: "Curicica",
      id_usuario: UUID.uuid4()
    }
  end
end
