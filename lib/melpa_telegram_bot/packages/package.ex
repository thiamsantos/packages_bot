defmodule MelpaTelegramBot.Packages.Package do
  use Ecto.Schema
  import Ecto.Changeset

  schema "packages" do
    field :name, :string
    field :description, :string
    field :recipe, :string
    field :homepage, :string
    field :total_downloads, :integer, default: 0

    timestamps()
  end

  @optional_fields [:description, :homepage, :total_downloads]
  @required_fields [:name, :recipe]

  @doc false
  def changeset(package, attrs) do
    package
    |> cast(attrs, @optional_fields ++ @required_fields)
  end
end
