defmodule PackagesBot.TelegramClient do
  def get_updates(bot_token, offset) do
    bot_token
    |> build_client()
    |> Tesla.post("/getUpdates", %{offset: offset, timeout: 1, allowed_updates: ["inline_query"]})
    |> handle_updates()
  end

  def answer_inline_query(bot_token, inline_query_id, results) do
    bot_token
    |> build_client()
    |> Tesla.post("/answerInlineQuery", %{inline_query_id: inline_query_id, results: results})
    |> handle_answer_inline()
  end

  defp build_client(bot_token) do
    base_url = "https://api.telegram.org/bot#{bot_token}"

    middleware = [
      {Tesla.Middleware.BaseUrl, base_url},
      {PackagesBot.TeslaLogger,
       filter_url: {~r(bot\w*:\w*\/), "bot<FILTERED>/"}, marker: __MODULE__},
      Tesla.Middleware.JSON
    ]

    Tesla.client(middleware)
  end

  defp handle_updates({:ok, %{status: 200, body: %{"ok" => true, "result" => updates}}}) do
    {:ok, updates}
  end

  defp handle_updates(_) do
    {:error, "Failed to get updates!"}
  end

  defp handle_answer_inline({:ok, %{status: 200, body: %{"ok" => true}}}) do
    :ok
  end

  defp handle_answer_inline(_) do
    {:error, "Failed to answer inline query!"}
  end
end
