defmodule PackagesBot.MixProject do
  use Mix.Project

  def project do
    [
      app: :packages_bot,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {PackagesBot.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.1"},
      {:postgrex, "~> 0.14.2"},
      {:jason, "~> 1.1"},
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false},
      {:distillery, "~> 2.0", runtime: false},
      {:excoveralls, "~> 0.10", only: :test},
      {:gen_tcp_accept_and_close, "~> 0.1.0"},
      {:timber, "~> 3.1", only: :prod},
      {:tesla, "~> 1.2"}
    ]
  end

  defp aliases do
    [
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate"]
    ]
  end
end
