defmodule MobPushAuth.RegistrationChallenge do
  use GenServer

  @enforce_keys [:id, :url]

  defstruct [:id, :url]

  def new(user) do
    id = :crypto.strong_rand_bytes(20)

    url =
      MobPushAuthWeb.Router.Helpers.mobile_register_url(MobPushAuthWeb.Endpoint, :index)
      <> "?id="
      <> Base.url_encode64(id, padding: false)

    :ets.insert(__MODULE__, {id, user})

    %__MODULE__{
      id: id,
      url: url
    }
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(_) do
    :ets.new(__MODULE__, [:public, :named_table])

    {:ok, []}
  end
end
