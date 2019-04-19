defmodule PackagesBot.Support.Fixtures do
  @hexpm_mutex "test/support/fixtures/hexpm_mutex.json"
               |> File.read!()
               |> Jason.decode!()

  @hexpm_mutex_gitlab "test/support/fixtures/hexpm_mutex_gitlab.json"
                      |> File.read!()
                      |> Jason.decode!()
  @hexpm_mutex_bitbucket "test/support/fixtures/hexpm_mutex_bitbucket.json"
                         |> File.read!()
                         |> Jason.decode!()
  @hexpm_phoenix "test/support/fixtures/hexpm_phoenix.json"
                 |> File.read!()
                 |> Jason.decode!()

  def hexpm("mutex"), do: @hexpm_mutex
  def hexpm("mutex_gitlab"), do: @hexpm_mutex_gitlab
  def hexpm("mutex_bitbucket"), do: @hexpm_mutex_bitbucket
  def hexpm("phoenix"), do: @hexpm_phoenix
end
