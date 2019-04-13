defmodule MelpaBot.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = children(env())

    opts = [strategy: :one_for_one, name: MelpaBot.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp children(:test) do
    [
      {MelpaBot.Repo, []}
    ]
  end

  defp children(_) do
    [
      {Task.Supervisor, name: MelpaBot.MessageSupervisor},
      {MelpaBot.Repo, []},
      {MelpaBot.Archive, []},
      {MelpaBot.Poller, []}
    ]
  end

  defp env do
    Application.fetch_env!(:melpa_bot, :env)
  end
end
