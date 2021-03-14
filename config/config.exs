import Config

Code.eval_file("./config/dotenv.exs")

config :packages_bot,
  env: Mix.env()

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

config :packages_bot, PackagesBotWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "14vchZs0C58eORwn06kcS2YI/3skmGnbvKDuKTcgmStch8i+8/Kux0dMswWngBWR",
  render_errors: [view: PackagesBotWeb.ErrorView, accepts: ~w(json)]

config :tesla, :adapter, Tesla.Adapter.Hackney

import_config "#{Mix.env()}.exs"
