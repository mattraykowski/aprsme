use Mix.Config

config :aprsme, AprsmeWeb.Endpoint, secret_key_base: System.get_env("SECRET_KEY_BASE")

config :aprsme, Aprsme.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")
