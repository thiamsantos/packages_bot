defmodule MelpaBot.Repo.Migrations.CreatePackages do
  use Ecto.Migration

  def change do
    create table(:packages) do
      add :name, :string, null: false
      add :description, :text
      add :recipe, :string, null: false
      add :homepage, :string
      add :total_downloads, :integer, null: false, default: 0

      timestamps()
    end

    create unique_index(:packages, [:name])
  end
end
