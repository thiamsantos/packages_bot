defmodule PackagesBot.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = children(env())

    opts = [strategy: :one_for_one, name: PackagesBot.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp children(:test) do
    [
      {PackagesBot.Repo, []}
    ]
  end

  defp children(_) do
    [
      {Task.Supervisor, name: PackagesBot.MessageSupervisor},
      {PackagesBot.Repo, []},
      {PackagesBot.Melpa.Archive, []},
      {PackagesBot.Poller, adapter: PackagesBot.Melpa}
    ]
  end

  defp env do
    Application.fetch_env!(:packages_bot, :env)
  end
end
