defmodule PackagesBot.Melpa.Archive do
  use GenServer

  alias PackagesBot.Melpa.Packages

  require Logger

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    Logger.info("[#{inspect(__MODULE__)}] Running.")

    :ets.new(__MODULE__, [:set, :protected, :named_table, read_concurrency: true])

    {:ok, state, {:continue, :update_archive}}
  end

  def handle_continue(:update_archive, state) do
    update_archive()

    {:noreply, state}
  end

  def handle_info(:update_archive, state) do
    update_archive()

    {:noreply, state}
  end

  defp update_archive do
    Logger.info("[#{inspect(__MODULE__)}] Updating archive.")

    {:ok, packages_renewed} = Packages.renew_packages()
    Logger.info("[#{inspect(__MODULE__)}] Updated #{packages_renewed} packages.")

    {:ok, packages_downloads_renewed} = Packages.renew_download_counts()
    Logger.info("[#{inspect(__MODULE__)}] Updated #{packages_downloads_renewed} download counts.")

    schedule_update()
  end

  defp schedule_update do
    Process.send_after(self(), :update_archive, renew_interval())
  end

  defp renew_interval do
    :packages_bot
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.fetch!(:renew_interval_in_seconds)
    |> :timer.seconds()
  end
end
