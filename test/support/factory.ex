defmodule PackagesBot.Factory do
  use ExMachina.Ecto, repo: PackagesBot.Repo

  alias PackagesBot.Melpa.Packages.Package

  def melpa_package_factory do
    name = Faker.Internet.user_name()

    %Package{
      name: name,
      description: Faker.Lorem.paragraph(1),
      recipe: "https://github.com/melpa/melpa/blob/master/recipes/#{name}",
      homepage: Faker.Internet.url(),
      total_downloads: Faker.random_between(0, 10_000)
    }
  end
end
