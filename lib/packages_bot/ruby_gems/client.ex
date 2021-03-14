defmodule PackagesBot.RubyGems.Client do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://rubygems.org"
  plug Tesla.Middleware.Headers, [{"user-agent", "RubyGems telegram bot"}]
  plug PackagesBot.TeslaLogger, marker: inspect(__MODULE__)
  plug Tesla.Middleware.DecodeJson

  def search(pattern) do
    case get("/api/v1/search.json", query: [query: pattern, page: "1"]) do
      {:ok, %{body: body, status: 200}} ->
        {:ok, body}

      _ ->
        {:error, "Failed to fetch packages!"}
    end
  end
end
