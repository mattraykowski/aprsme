# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :aprsme,
  ecto_repos: [Aprsme.Repo]

# Configures the endpoint
config :aprsme, AprsmeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+mzul2LNGjl88vOYqnxPa/wkFwfeHa1PNGcj3j1GPqDa2Kajf/RFdQpG1g4RMHkF",
  render_errors: [view: AprsmeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Aprsme.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "[$time] $metadata[$level]$levelpad$message",
  metadata: [:all]

config :aprsme,
  rabbitmq_url: System.get_env("RABBITMQ_URL") || "amqp://user:bitnami@127.0.0.1:5672/aprs"

config :aprsme, Aprsme.Repo,
  types: Aprsme.PostgresTypes

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
