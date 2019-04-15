~w(rel plugins *.exs)
|> Path.join()
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Mix.Releases.Config,
    # This sets the default release built by `mix release`
    default_release: :default,
    # This sets the default environment used by `mix release`
    default_environment: Mix.env()

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"1{x<pHA!Z&v7^g2Ep;/wDrd>]6zq<~%(6zi0@Ol?qxw%q*f&5n[/e@4q`UT$Ejz|"
  set pre_start_hooks: "rel/hooks/pre_start"
  set config_providers: [
    {Mix.Releases.Config.Providers.Elixir, ["${RELEASE_ROOT_DIR}/etc/config.exs"]}
  ]
  set overlays: [
    {:copy, "rel/config/config.exs", "etc/config.exs"}
  ]
end

release :packages_bot do
  set version: current_version(:packages_bot)
  set applications: [
    :runtime_tools,
    packages_bot: :permanent
  ]
end
