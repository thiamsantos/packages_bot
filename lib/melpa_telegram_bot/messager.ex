defmodule MelpaBot.Messager do
  alias MelpaBot.Packages

  require Logger

  def send(chat_id, package_name) do
    description =
      "http://melpa.org/packages/#{package_name}-readme.txt"
      |> HTTPoison.get!()
      |> Map.fetch!(:body)

    case Nadia.send_message(chat_id, description) do
      {:ok, _message} ->
        Logger.info("Description of #{package_name} sended.")

      {:error, error} ->
        raise error
    end
  end

  def answer_inline_query(inline_query_id, pattern) do
    result =
      pattern
      |> Packages.search_package()
      |> Enum.map(fn package ->
        %Nadia.Model.InlineQueryResult.Article{
          id: package.id,
          title: package.name,
          description: package.description,
          input_message_content: %Nadia.Model.InputMessageContent.Text{
            message_text:
              "<strong>Package</strong>: #{package.name}\n<strong>Description</strong>: #{
                package.description
              }\n\n<strong>Total downloads</strong>: #{package.total_downloads}",
            parse_mode: "HTML"
          },
          reply_markup: %Nadia.Model.InlineKeyboardMarkup{
            inline_keyboard: [
              build_inline_keyboard(package)
            ]
          }
        }
      end)

    :ok = Nadia.answer_inline_query(inline_query_id, result)

    Logger.info("#{__MODULE__} Answered #{inspect(pattern)} with success!")
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
