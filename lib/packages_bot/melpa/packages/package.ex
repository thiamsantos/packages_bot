defmodule PackagesBot.Melpa.Packages.Package do
  use Ecto.Schema
  import PackagesBot.Package

  schema "melpa_packages" do
    field :name, :string
    field :description, :string
    field :recipe, :string
    field :homepage, :string
    field :total_downloads, :integer, default: 0

    timestamps()
  end

  def to_telegram(%__MODULE__{} = melpa_package) do
    melpa_package.name
    |> new_package()
    |> put_id("melpa:#{melpa_package.id}")
    |> put_description(melpa_package.description)
    |> put_total_downloads(melpa_package.total_downloads)
    |> put_link("Recipe", melpa_package.recipe)
    |> put_link("Homepage", melpa_package.homepage)
  end
end
