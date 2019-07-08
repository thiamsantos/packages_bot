defmodule PackagesBot.Hexpm.Packages do
  import PackagesBot.Package
  alias PackagesBot.Hexpm.Client

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

        links =
          package
          |> get_in([Access.key("meta", %{}), Access.key("links", %{})])
          |> Enum.map(fn {key, value} -> {String.downcase(key), value} end)
          |> Map.new()

        name
        |> new_package()
        |> put_id("hexpm:#{name}")
        |> put_description(get_in(package, [Access.key("meta", %{}), "description"]))
        |> put_total_downloads(get_in(package, [Access.key("downloads", %{}), "all"]))
        |> put_link("Repository", links["github"] || links["gitlab"] || links["bitbucket"])
        |> put_link("Package", Map.get(package, "html_url"))
      end)

    {:ok, parsed_packages}
  end
end
