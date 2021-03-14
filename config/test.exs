import Config

config :logger, level: :warn

config :tesla, adapter: Tesla.Mock

config :packages_bot, PackagesBotWeb.Endpoint,
  http: [port: 4002],
  server: false
