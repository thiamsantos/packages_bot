~w(rel *.exs)
|> Path.join()
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Mix.Releases.Config,
    default_release: :prod,
    default_environment: :prod

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"1{x<pHA!Z&v7^g2Ep;/wDrd>]6zq<~%(6zi0@Ol?qxw%q*f&5n[/e@4q`UT$Ejz|"
  set vm_args: "rel/vm.args"
end

release :melpa_bot do
  set version: current_version(:melpa_bot)
  set applications: [
    :runtime_tools,
    :logger
  ]
  set config_providers: [
    {Mix.Releases.Config.Providers.Elixir, ["${RELEASE_ROOT_DIR}/etc/config.exs"]}
  ]
  set overlays: [
    {:copy, "rel/config/config.exs", "etc/config.exs"}
  ]
end
