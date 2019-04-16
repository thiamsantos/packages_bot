defmodule PackagesBot.CurrentTime do
  @behaviour PackagesBot.CurrentTime.Adapter

  @adapter :packages_bot
           |> Application.fetch_env!(__MODULE__)
           |> Keyword.fetch!(:adapter)

  defdelegate naive_now, to: @adapter
end
