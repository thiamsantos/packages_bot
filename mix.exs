defmodule MelpaTelegramBot.MixProject do
  use Mix.Project

  def project do
    [
      app: :melpa_telegram_bot,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {MelpaTelegramBot.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nadia, "~> 0.4.4"},
      {:httpoison, "~> 1.5", override: true},
      {:floki, "~> 0.20.4"}
    ]
  end
end
