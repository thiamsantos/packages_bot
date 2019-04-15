defmodule PackagesBot.Repo do
  use Ecto.Repo,
    otp_app: :packages_bot,
    adapter: Ecto.Adapters.Postgres
end
