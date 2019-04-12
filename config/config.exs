use Mix.Config

__ENV__.file()
|> Path.dirname()
|> Path.join("./dotenv.exs")
|> Path.expand()
|> Code.eval_file()

config :nadia,
  token: Dotenv.fetch_env!("TELEGRAM_BOT_TOKEN")

config :melpa_telegram_bot,
  ecto_repos: [MelpaTelegramBot.Repo]

config :melpa_telegram_bot, MelpaTelegramBot.Repo, url: Dotenv.fetch_env!("DATABASE_URL")

config :melpa_telegram_bot, MelpaTelegramBot.Archive,
  renew_interval_in_seconds: Dotenv.fetch_integer_env!("ARCHIVE_RENEW_INTERVAL_IN_SECONDS")
