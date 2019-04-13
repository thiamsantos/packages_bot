defmodule MelpaBot.Repo do
  use Ecto.Repo,
    otp_app: :melpa_bot,
    adapter: Ecto.Adapters.Postgres
end
