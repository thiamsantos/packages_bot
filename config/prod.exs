use Mix.Config

config :packages_bot, PackagesBot.Repo, pool_size: 2

config :logger,
  backends: [Logger.Backends.Console, Timber.LoggerBackends.HTTP],
  level: :info,
  metadata: [:module],
  format: "$time $metadata[$level] $message\n"

config :timber,
  api_key: System.get_env("TIMBER_API_KEY"),
  source_id: System.get_env("TIMBER_SOURCE_ID")
