defmodule PackagesBotWeb.HeartCheck do
  use HeartCheck

  alias PackagesBot.Repo

  add :database do
    case ping_repo(Repo) do
      {:ok, _} -> :ok
      {:error, exception} -> {:error, Exception.message(exception)}
    end
  end

  firewall(
    melpa: "https://melpa.org",
    telegram: "https://api.telegram.org",
    rubygems: "https://rubygems.org",
    hexpm: "https://hex.pm"
  )

  defp ping_repo(repo) do
    repo.query("SELECT 1")
  rescue
    exception -> {:error, exception}
  end
end
