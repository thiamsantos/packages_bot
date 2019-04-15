defmodule PackagesBot.Messager do
  alias PackagesBot.TelegramClient

  require Logger

  def answer_inline_query(adapter, inline_query_id, pattern) do
    result =
      pattern
      |> adapter.search_package()
      |> Enum.map(fn package ->
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
              build_inline_keyboard(package)
            ]
          }
        }
      end)

    :ok = TelegramClient.answer_inline_query(adapter.bot_token, inline_query_id, result)

    Logger.info("[#{__MODULE__}] Answered #{inspect(pattern)} with success for #{adapter}!")
  end

  defp build_inline_keyboard(package) do
    [
      %{
        text: "Homepage",
        url: package.homepage
      },
      %{
        text: "Recipe",
        url: package.recipe
      }
    ]
    |> Enum.reject(fn %{url: url} -> is_nil(url) end)
  end
end
