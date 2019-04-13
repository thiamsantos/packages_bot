defmodule MelpaBot.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Task.Supervisor, name: MelpaBot.MessageSupervisor},
      {MelpaBot.Repo, []},
      {MelpaBot.Archive, []},
      {MelpaBot.Poller, []}
    ]

    opts = [strategy: :one_for_one, name: MelpaBot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
