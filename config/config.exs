use Mix.Config

__ENV__.file()
|> Path.dirname()
|> Path.join("./dotenv.exs")
|> Path.expand()
|> Code.eval_file()

config :nadia,
  token: Dotenv.fetch_env!("TELEGRAM_BOT_TOKEN")

config :melpa_bot,
  ecto_repos: [MelpaBot.Repo]

config :melpa_bot, MelpaBot.Repo, url: Dotenv.fetch_env!("DATABASE_URL")

config :melpa_bot, MelpaBot.Archive,
  renew_interval_in_seconds: Dotenv.fetch_integer_env!("ARCHIVE_RENEW_INTERVAL_IN_SECONDS")

if Mix.env() == :prod do
  config :logger, level: :info
end
