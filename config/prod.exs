use Mix.Config

config :melpa_bot, MelpaBot.Repo, pool_size: 2

config :logger,
  backends: [Timber.LoggerBackends.HTTP],
  level: :info

config :timber,
  api_key: Dotenv.fetch_env!("TIMBER_API_KEY"),
  source_id: Dotenv.fetch_env!("TIMBER_SOURCE_ID")
