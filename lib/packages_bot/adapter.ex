defmodule PackagesBot.Adapter do
  @callback bot_token :: String.t()
  @callback search_package(String.t()) :: {:ok, [%{}]} | {:error, String.t()}
end
