defmodule MelpaBot.Poller do
  use GenServer

  require Logger

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{offset: 0})
  end

  def init(state) do
    :timer.send_interval(500, :poll)

    Logger.info("#{__MODULE__} Running.")

    {:ok, state}
  end

  def handle_info(:poll, %{offset: current_offset}) do
    new_offset =
      [offset: current_offset]
      |> Nadia.get_updates()
      |> handle_updates(current_offset)

    {:noreply, %{offset: new_offset}}
  end

  defp handle_updates({:ok, []}, current_offset), do: current_offset

  defp handle_updates({:ok, updates}, _current_offset) when is_list(updates) do
    updates
    |> send_messages()
    |> get_new_offset()
  end

  defp handle_updates(_other, current_offset), do: current_offset

  defp send_messages(updates) do
    Enum.each(updates, fn update ->
      case update do
        %{inline_query: %{id: inline_query_id, query: pattern}} ->
          answer_inline_query(inline_query_id, pattern)

        other ->
          other
      end
    end)

    updates
  end

  defp get_new_offset(updates) do
    update_id =
      updates
      |> List.last()
      |> Map.get(:update_id)

    update_id + 1
  end

  defp answer_inline_query(inline_query_id, pattern) do
    Task.Supervisor.start_child(
      MelpaBot.MessageSupervisor,
      MelpaBot.Messager,
      :answer_inline_query,
      [inline_query_id, pattern]
    )
  end
end
