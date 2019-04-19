defmodule PackagesBot.Hexpm.Client do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://hex.pm/api"
  plug Tesla.Middleware.Headers, [{"user-agent", "Hexpm telegram bot"}]
  plug PackagesBot.TeslaLogger, marker: __MODULE__
  plug Tesla.Middleware.DecodeJson, decode_content_types: ["application/vnd.hex+json"]

  def search(pattern) do
    case get("/packages", query: [search: pattern, sort: "downloads"]) do
      {:ok, %{body: body, status: 200}} ->
        {:ok, body}

      _ ->
        {:error, "Failed to fetch packages!"}
    end
  end
end
