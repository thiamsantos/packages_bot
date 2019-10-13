defmodule PackagesBot.MixProject do
  use Mix.Project

  def project do
    [
      app: :packages_bot,
      version: "0.1.0",
      elixir: "~> 1.8",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      compilers: [:phoenix] ++ Mix.compilers(),
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

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.1"},
      {:postgrex, "~> 0.14.2"},
      {:jason, "~> 1.1"},
      {:tesla, "~> 1.2"},
      {:timber, "~> 3.1", only: :prod},
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false},
      {:distillery, "~> 2.0", runtime: false},
      {:excoveralls, "~> 0.10", only: :test},
      {:mox, "~> 0.5.0", only: :test},
      {:ex_machina, "~> 2.3", only: :test},
      {:faker, "~> 0.12.0", only: :test},
      {:sentry, "~> 7.1"},
      {:plug_cowboy, "~> 2.1"},
      {:phoenix, "~> 1.4"},
      {:heartcheck, "~> 0.4.1"}
    ]
  end

  defp aliases do
    [
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate"]
    ]
  end
end
