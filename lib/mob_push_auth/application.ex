defmodule MobPushAuth.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      MobPushAuthWeb.Telemetry,
      {Phoenix.PubSub, name: MobPushAuth.PubSub},
      MobPushAuthWeb.Endpoint,
      MobPushAuth.SubscriptionStore
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MobPushAuth.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MobPushAuthWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
