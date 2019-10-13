use Mix.Config

__ENV__.file()
|> Path.dirname()
|> Path.join("./dotenv.exs")
|> Path.expand()
|> Code.eval_file()

config :packages_bot,
  ecto_repos: [PackagesBot.Repo],
  env: Mix.env()

config :packages_bot, PackagesBot.Repo, url: System.get_env("DATABASE_URL")

config :packages_bot, PackagesBot.Melpa.Archive,
  renew_interval_in_seconds: Dotenv.fetch_integer_env!("ARCHIVE_RENEW_INTERVAL_IN_SECONDS")

config :packages_bot, PackagesBot.Melpa, bot_token: System.get_env("MELPA_BOT_TOKEN")
config :packages_bot, PackagesBot.Hexpm, bot_token: System.get_env("HEXPM_BOT_TOKEN")
config :packages_bot, PackagesBot.RubyGems, bot_token: System.get_env("RUBY_GEMS_BOT_TOKEN")

config :packages_bot, PackagesBot.CurrentTime, adapter: PackagesBot.CurrentTime.SystemAdapter

config :sentry,
  dsn: System.get_env("SENTRY_DSN"),
  included_environments: [:prod],
  environment_name: Mix.env()

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

config :packages_bot, PackagesBotWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "14vchZs0C58eORwn06kcS2YI/3skmGnbvKDuKTcgmStch8i+8/Kux0dMswWngBWR",
  render_errors: [view: PackagesBotWeb.ErrorView, accepts: ~w(json)]

import_config "#{Mix.env()}.exs"
