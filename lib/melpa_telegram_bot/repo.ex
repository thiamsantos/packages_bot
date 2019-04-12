defmodule MelpaTelegramBot.Repo do
  use Ecto.Repo,
    otp_app: :melpa_telegram_bot,
    adapter: Ecto.Adapters.Postgres
end
