# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :aprsme,
  ecto_repos: [Aprsme.Repo]

config :phoenix, :json_library, Jason

# Configures the endpoint
config :aprsme, AprsmeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+mzul2LNGjl88vOYqnxPa/wkFwfeHa1PNGcj3j1GPqDa2Kajf/RFdQpG1g4RMHkF",
  render_errors: [view: AprsmeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Aprsme.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "[$time] $metadata[$level]$levelpad$message",
  metadata: [:all]

config :aprsme,
  rabbitmq_url: System.get_env("RABBITMQ_URL") || "amqp://user:bitnami@127.0.0.1:5672/aprs"

config :aprsme, Aprsme.Repo, types: Aprsme.PostgresTypes

config :aprsme, Aprsme.Scheduler,
  # Don't schedule to run on all nodes in the cluster
  global: true,
  jobs: [
    purge_packets: [
      schedule: System.get_env("SCHEDULE_PURGE_PACKETS") || "@hourly",
      task: {Aprsme.PurgePacketWorker, :run, []}
    ]
  ]

config :aprsme,
  purge_packet_count: System.get_env("PACKET_PURGE_COUNT") || 1,
  purge_packet_interval: System.get_env("PACKET_PURGE_INTERVAL") || "day"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
