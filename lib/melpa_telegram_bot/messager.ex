defmodule MelpaTelegramBot.Messager do
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
end
