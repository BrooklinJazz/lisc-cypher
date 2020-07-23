# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :lisc_cypher,
  ecto_repos: [LiscCypher.Repo]

# Configures the endpoint
config :lisc_cypher, LiscCypherWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1USjriAsTF1qr57/20lYa/TWQSqP0J29nkJbLtRVeKvmT6VdH1/uYDpYe3GUvcl2",
  render_errors: [view: LiscCypherWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: LiscCypher.PubSub,
  live_view: [signing_salt: "VQLxb6aP"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
