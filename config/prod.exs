use Mix.Config

config :logger,
  backends: [:console],
  level: :info,
  metadata: [:module, :request_id],
  format: "$time $metadata[$level] $message\n",
  utc_log: true

config :logger, :console,
  format: {Timber.Formatter, :format},
  metadata: :all
