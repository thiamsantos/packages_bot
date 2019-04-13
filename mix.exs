defmodule MelpaBot.MixProject do
  use Mix.Project

  def project do
    [
      app: :melpa_bot,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {MelpaBot.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nadia, "~> 0.4.4"},
      {:httpoison, "~> 1.5", override: true},
      {:ecto_sql, "~> 3.1"},
      {:postgrex, "~> 0.14.2"},
      {:jason, "~> 1.1"}
    ]
  end

  defp aliases do
    [
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate"]
    ]
  end
end
