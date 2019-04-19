defmodule PackagesBot.Poller do
  use GenServer

  require Logger

  def start_link(opts) do
    adapter = Keyword.fetch!(opts, :adapter)
    GenServer.start_link(__MODULE__, %{offset: 0, adapter: adapter})
  end

  def child_spec(opts) do
    %{
      id: Keyword.fetch!(opts, :adapter),
      start: {__MODULE__, :start_link, [opts]}
    }
  end

  def init(%{adapter: adapter} = state) do
    Logger.info("[#{__MODULE__}] running with #{adapter} adapter.")

    {:ok, state, {:continue, :poll}}
  end

  def handle_continue(:poll, state) do
    poll(state)

    {:noreply, state}
  end

  def handle_info(:poll, state) do
    poll(state)

    {:noreply, state}
  end

  defp poll(%{offset: current_offset, adapter: adapter} = state) do
    new_offset =
      adapter.bot_token()
      |> PackagesBot.TelegramClient.get_updates(current_offset)
      |> handle_updates(state)

    schedule_poll()

    {:noreply, %{state | offset: new_offset}}
  end

  defp handle_updates({:ok, []}, %{offset: current_offset}), do: current_offset

  defp handle_updates({:ok, updates}, %{adapter: adapter}) when is_list(updates) do
    adapter
    |> send_messages(updates)
    |> get_new_offset()
  end

  defp handle_updates(_other, %{offset: current_offset}), do: current_offset

  defp send_messages(adapter, updates) do
    Enum.each(updates, fn update ->
      with %{"inline_query" => %{"id" => inline_query_id, "query" => pattern}} when pattern != "" <-
             update do
        answer_inline_query(adapter, inline_query_id, pattern)
      end
    end)

    updates
  end

  defp get_new_offset(updates) do
    update_id =
      updates
      |> List.last()
      |> Map.get("update_id")

    update_id + 1
  end

  defp answer_inline_query(adapter, inline_query_id, pattern) do
    Task.Supervisor.start_child(
      PackagesBot.MessageSupervisor,
      PackagesBot.Messager,
      :answer_inline_query,
      [adapter, inline_query_id, pattern]
    )
  end

  defp schedule_poll do
    Process.send_after(self(), :poll, polling_interval())
  end

  defp polling_interval do
    500
  end
end
