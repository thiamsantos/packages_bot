defmodule PackagesBot.Package do
  defstruct [:id, :name, :description, :total_downloads, :links]

  alias PackagesBot.Link

  def new_package(name) do
    %__MODULE__{name: name, links: []}
  end

  def put_id(%__MODULE__{} = package, id) do
    %{package | id: id}
  end

  def put_description(%__MODULE__{} = package, description) do
    %{package | description: description}
  end

  def put_total_downloads(%__MODULE__{} = package, total_downloads) do
    %{package | total_downloads: total_downloads}
  end

  def put_link(%__MODULE__{links: links} = package, text, url) when not is_nil(url) do
    links = [%Link{text: text, url: url} | links]
    %{package | links: Enum.reverse(links)}
  end

  def put_link(%__MODULE__{} = package, _text, _url), do: package
end
