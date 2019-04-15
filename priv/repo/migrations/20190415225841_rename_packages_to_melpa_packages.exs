defmodule PackagesBot.Repo.Migrations.RenamePackagesToMelpaPackages do
  use Ecto.Migration

  def change do
    rename table("packages"), to: table("melpa_packages")
  end
end
