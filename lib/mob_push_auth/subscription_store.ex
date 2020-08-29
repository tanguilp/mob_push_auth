defmodule MobPushAuth.SubscriptionStore do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [])
  end

  def get(login) do
    case :ets.lookup(__MODULE__, login) do
      [{_login, data}] ->
        data

      [] ->
        nil
    end
  end

  def put(login, subscription_info) do
    :ets.insert(__MODULE__, {login, subscription_info})
  end

  @impl true
  def init(_) do
    :ets.new(__MODULE__, [:public, :named_table])

    {:ok, []}
  end
end
