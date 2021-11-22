defmodule PackagesBot.Melpa.Packages do
  import PackagesBot.Package
  alias PackagesBot.Melpa.Archive
  alias PackagesBot.Melpa.Client

  def renew_packages do
    case Client.archive() do
      {:ok, packages} -> insert_all(packages)
      {:error, reason} -> {:error, reason}
    end
  end

  def renew_download_counts do
    case Client.download_counts() do
      {:ok, download_counts} -> update_download_counts(download_counts)
      {:error, reason} -> {:error, reason}
    end
  end

  def search_package(pattern) do
    packages =
      Archive
      |> :ets.tab2list()
      |> Enum.filter(fn {name, description, _homepage, _total_downloads} ->
        content = String.downcase(name <> description)

        String.contains?(content, String.downcase(pattern))
      end)
      |> Enum.sort_by(
        fn {_name, _description, _homepage, total_downloads} -> total_downloads end,
        :desc
      )
      |> Enum.take(5)
      |> Enum.map(&to_telegram/1)

    {:ok, packages}
  end

  defp to_telegram({name, description, homepage, total_downloads}) do
    name
    |> new_package()
    |> put_id("melpa:#{name}")
    |> put_description(description)
    |> put_total_downloads(total_downloads)
    |> put_link("Recipe", "https://github.com/melpa/melpa/blob/master/recipes/#{name}")
    |> put_link("Homepage", homepage)
  end

  defp insert_all(packages) do
    entries_amount =
      packages
      |> Enum.map(fn {name, meta} ->
        :ets.insert(
          Archive,
          {name, Map.get(meta, "desc", ""), get_in(meta, [Access.key("props", %{}), "url"]), 0}
        )
      end)
      |> Enum.count()

    {:ok, entries_amount}
  end

  defp update_download_counts(download_counts) do
    entries_amount =
      download_counts
      |> Enum.map(fn {name, total_downloads} ->
        :ets.update_element(Archive, name, [{4, total_downloads}])
      end)
      |> Enum.filter(&Function.identity/1)
      |> Enum.count()

    {:ok, entries_amount}
  end
end
