defmodule Flightex.Users.Agent do
  use Agent

  alias Flightex.Users.User

  def start_link(_inicial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{} = user) do
    Agent.update(__MODULE__, &update_state(&1, user))
    {:ok, user.id}
  end

  def get(uuid), do: Agent.get(__MODULE__, &get_user(&1, uuid))

  defp get_user(state, uuid) do
    case Map.get(state, uuid) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end

  defp update_state(state, %User{id: id} = user), do: Map.put(state, id, user)
end
