defmodule PackagesBotWeb.Router do
  use PackagesBotWeb, :router

  forward "/monitoring", HeartCheck.Plug, heartcheck: PackagesBotWeb.HeartCheck
end
