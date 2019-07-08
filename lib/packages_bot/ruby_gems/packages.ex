defmodule PackagesBot.RubyGems.Packages do
  import PackagesBot.Package
  alias PackagesBot.RubyGems.Client

  def search(pattern) do
    pattern
    |> Client.search()
    |> parse_packages()
  end

  defp parse_packages({:error, reason}), do: {:error, reason}

  defp parse_packages({:ok, packages}) do
    parsed_packages =
      packages
      |> Enum.take(5)
      |> Enum.map(fn package ->
        name = Map.get(package, "name")

        name
        |> new_package()
        |> put_id("ruby_gems:#{name}")
        |> put_description(Map.get(package, "info"))
        |> put_total_downloads(Map.get(package, "downloads"))
        |> put_link("Repository", Map.get(package, "source_code_uri"))
        |> put_link("Package", Map.get(package, "project_uri"))
      end)

    {:ok, parsed_packages}
  end
end
