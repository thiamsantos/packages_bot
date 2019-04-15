defmodule PackagesBot.Packages do
  alias PackagesBot.Packages.{Loader, Package}
  alias PackagesBot.Repo

  require Logger

  @archive_url "https://melpa.org/archive.json"
  @download_counts_url "https://melpa.org/download_counts.json"

  def renew_packages do
    @archive_url
    |> fetch_data()
    |> parse_packages()
    |> insert_all_packages()
  end

  def renew_download_counts do
    @download_counts_url
    |> fetch_data()
    |> parse_download_counts()
    |> insert_all_download_counts()
  end

  defdelegate search_package(pattern), to: Loader

  defp fetch_data(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Logger.info("[#{__MODULE__}] Fetched #{url} with success!")
        {:ok, Jason.decode!(body)}

      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        Logger.error("#{__MODULE__} Failed to fetching #{url}. status_code: #{status_code}.")

        {:error, "Failed to fetch #{url}"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("#{__MODULE__} Failed to fetch #{url}. reason: #{inspect(reason)}.")

        {:error, "Failed to fetch #{url}"}
    end
  end

  defp parse_packages({:error, reason}), do: {:error, reason}

  defp parse_packages({:ok, raw_packages}) do
    packages =
      Enum.map(raw_packages, fn {name, meta} ->
        %{
          name: name,
          description: Map.get(meta, "desc"),
          recipe: "https://github.com/melpa/melpa/blob/master/recipes/#{name}",
          homepage: get_in(meta, [Access.key("props", %{}), "url"]),
          inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second),
          updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)
        }
      end)

    {:ok, packages}
  end

  defp parse_download_counts({:error, reason}), do: {:error, reason}

  defp parse_download_counts({:ok, raw_download_counts}) do
    download_counts =
      Enum.map(raw_download_counts, fn {name, total_downloads} ->
        %{
          name: name,
          recipe: "https://github.com/melpa/melpa/blob/master/recipes/#{name}",
          total_downloads: total_downloads,
          inserted_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second),
          updated_at: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)
        }
      end)

    {:ok, download_counts}
  end

  defp insert_all_packages({:error, reason}), do: {:error, reason}

  defp insert_all_packages({:ok, packages}) do
    Repo.insert_all(Package, packages,
      conflict_target: :name,
      on_conflict: {:replace, [:description, :recipe, :homepage, :updated_at]}
    )
  end

  defp insert_all_download_counts({:error, reason}), do: {:error, reason}

  defp insert_all_download_counts({:ok, download_counts}) do
    Repo.insert_all(Package, download_counts,
      conflict_target: :name,
      on_conflict: {:replace, [:recipe, :total_downloads, :updated_at]}
    )
  end
end
