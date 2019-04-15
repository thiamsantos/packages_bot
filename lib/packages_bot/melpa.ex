defmodule PackagesBot.Melpa do
  @behaviour PackagesBot.Adapter

  alias PackagesBot.Melpa.Packages

  def bot_token do
    :packages_bot
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.fetch!(:bot_token)
  end

  def search_package(pattern) do
    Packages.search_package(pattern)
  end
end
