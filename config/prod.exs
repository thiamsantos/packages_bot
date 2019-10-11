use Mix.Config

config :logger,
  backends: [:console],
  level: :info,
  metadata: [:module],
  format: "$time $metadata[$level] $message\n",
  utc_log: true

config :logger, :console,
  format: {Timber.Formatter, :format},
  metadata: :all

config :timber,
  api_key: System.get_env("TIMBER_API_KEY"),
  source_id: System.get_env("TIMBER_SOURCE_ID")
