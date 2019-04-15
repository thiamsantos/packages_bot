defmodule PackagesBot.MelpaClient do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://melpa.org"
  plug Tesla.Middleware.Logger
  plug Tesla.Middleware.JSON

  def archive do
    case get("archive.json") do
      {:ok, %{body: body, status: 200}} -> {:ok, body}
      _ -> {:error, "Failed to fetch archive!"}
    end
  end

  def download_counts do
    case get("download_counts.json") do
      {:ok, %{body: body, status: 200}} -> {:ok, body}
      _ -> {:error, "Failed to fetch download counts!"}
    end
  end
end
