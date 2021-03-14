defmodule PackagesBotWeb.HeartCheck do
  use HeartCheck

  firewall(
    melpa: "https://melpa.org",
    telegram: "https://api.telegram.org",
    rubygems: "https://rubygems.org",
    hexpm: "https://hex.pm"
  )
end
