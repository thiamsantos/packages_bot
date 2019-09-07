defmodule PackagesBot.Messager do
  alias PackagesBot.{Package, TelegramClient}

  require Logger

  def answer_inline_query(adapter, inline_query_id, pattern) do
    context = %{adapter: adapter, inline_query_id: inline_query_id, pattern: pattern}

    pattern
    |> adapter.search_package()
    |> handle_search(context)
  end

  defp handle_search({:ok, packages}, context) do
    %{adapter: adapter, inline_query_id: inline_query_id, pattern: pattern} = context

    result = Enum.map(packages, &format_package/1)

    TelegramClient.answer_inline_query(adapter.bot_token, inline_query_id, result)

    Logger.info("Answered #{inspect(pattern)} with success for #{adapter}!")
  end

  defp handle_search({:error, reason}, %{adapter: adapter, pattern: pattern}) do
    Logger.error("Failed to answer #{inspect(pattern)} for #{adapter} with #{inspect(reason)}!")
  end

  defp format_package(%Package{} = package) do
    %{
      type: "article",
      id: package.id,
      title: package.name,
      description: package.description,
      input_message_content: %{
        message_text:
          "<strong>Package</strong>: #{package.name}\n<strong>Description</strong>: #{
            package.description
          }\n\n<strong>Total downloads</strong>: #{package.total_downloads}",
        parse_mode: "HTML"
      },
      reply_markup: %{
        inline_keyboard: [
          package.links
        ]
      }
    }
  end
end
