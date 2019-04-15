defmodule PackagesBot.Adapter do
  @callback bot_token :: String.t()
  @callback search_package(String.t()) :: [PackagesBot.Packages.Package.t()]
end
