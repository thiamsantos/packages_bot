use Mix.Config

config :melpa_bot, MelpaBot.Repo, pool_size: 2

config :logger,
  backends: [Timber.LoggerBackends.HTTP],
  level: :info

config :timber,
  api_key: Dotenv.fetch_env!("TIMBER_API_KEY"),
  source_id: Dotenv.fetch_env!("TIMBER_SOURCE_ID")

config :sentry,
  dsn: Dotenv.fetch_env!("SENTRY_ENDPOINT"),
  environment_name: Mix.env(),
  enable_source_code_context: true,
  root_source_code_path: File.cwd!(),
  included_environments: [:prod]
