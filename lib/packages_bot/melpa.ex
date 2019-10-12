defmodule PackagesBot.Melpa do
  @behaviour PackagesBot.Adapter

  alias PackagesBot.Melpa.Packages

  @impl true
  def bot_token do
    :packages_bot
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.fetch!(:bot_token)
  end

  @impl true
  def search_package(pattern) do
    if pattern == "boom" do
      raise RuntimeError, "boom"
    end

    Packages.search_package(pattern)
  end
end
