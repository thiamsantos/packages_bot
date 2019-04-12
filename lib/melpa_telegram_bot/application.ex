defmodule MelpaTelegramBot.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Task.Supervisor, name: MelpaTelegramBot.MessageSupervisor},
      {MelpaTelegramBot.Repo, []},
      {MelpaTelegramBot.Archive, []},
      {MelpaTelegramBot.Poller, []}
    ]

    opts = [strategy: :one_for_one, name: MelpaTelegramBot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
