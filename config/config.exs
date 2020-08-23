# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :mob_push_auth, MobPushAuthWeb.Endpoint,
url: [host:
      :inet.getif() |> elem(1) |> List.first() |> elem(0) |> Tuple.to_list() |> Enum.join(".")
  ],
  secret_key_base: "rm8bH5zt/D+jr15qkZc/EMN+zN8sRok5wPWkdaI3gpjWlxLz/WwYrz31YF1WIQPH",
  render_errors: [view: MobPushAuthWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: MobPushAuth.PubSub,
  live_view: [signing_salt: "wivD01qB"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
