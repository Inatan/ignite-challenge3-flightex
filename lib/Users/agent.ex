defmodule Flightex.Users.Agent do
  use Agent

  alias Flightex.Users.User

  def start_link(_inicial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{} = user), do: Agent.update(__MODULE__, &update_state(&1, user))

  defp update_state(state, %User{id: id} = user), do: Map.put(state, id, user)
end
