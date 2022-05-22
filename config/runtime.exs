import Config

config :packages_bot, PackagesBot.Melpa.Archive,
  renew_interval_in_seconds:
    String.to_integer(System.get_env("ARCHIVE_RENEW_INTERVAL_IN_SECONDS", "3600"))

config :packages_bot, PackagesBot.Melpa, bot_token: System.fetch_env!("MELPA_BOT_TOKEN")
config :packages_bot, PackagesBot.Hexpm, bot_token: System.fetch_env!("HEXPM_BOT_TOKEN")
config :packages_bot, PackagesBot.RubyGems, bot_token: System.fetch_env!("RUBY_GEMS_BOT_TOKEN")

config :sentry,
  dsn: System.get_env("SENTRY_DSN"),
  included_environments: [:prod],
  environment_name: config_env()

if config_env() == :prod do
  config :packages_bot, PackagesBotWeb.Endpoint,
    http: [port: String.to_integer(System.get_env("PORT") || "4000")],
    server: true
end
