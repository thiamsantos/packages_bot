use Mix.Config

config :packages_bot, PackagesBot.Repo, pool: Ecto.Adapters.SQL.Sandbox

config :logger, level: :warn

config :tesla, adapter: Tesla.Mock

config :packages_bot, PackagesBot.CurrentTime, adapter: PackagesBot.CurrentTimeMock

config :packages_bot, PackagesBotWeb.Endpoint,
  http: [port: 4002],
  server: false
