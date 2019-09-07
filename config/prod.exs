use Mix.Config

config :packages_bot, PackagesBot.Repo, pool_size: 2

config :logger,
  backends: [Timber.LoggerBackends.HTTP],
  level: :info,
  metadata: [:module],
  format: "$time $metadata[$level] $message\n"

config :timber,
  api_key: Dotenv.fetch_env!("TIMBER_API_KEY"),
  source_id: Dotenv.fetch_env!("TIMBER_SOURCE_ID")
