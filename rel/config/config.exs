use Mix.Config

parse_integer = fn value ->
  value |> Integer.parse |> elem(0)
end

fetch_env! = fn key ->
  case System.get_env(key) do
    nil -> raise ArgumentError, "Could not fetch environment #{key} because configuration #{key} was not set"
    value -> value
  end
end

config :nadia,
  token: fetch_env!("TELEGRAM_BOT_TOKEN")

config :melpa_bot,
  ecto_repos: [MelpaBot.Repo]

config :melpa_bot, MelpaBot.Repo, url: fetch_env!("DATABASE_URL")

config :melpa_bot, MelpaBot.Archive,
  renew_interval_in_seconds: "ARCHIVE_RENEW_INTERVAL_IN_SECONDS" |> fetch_env!() |> String.to_integer()
