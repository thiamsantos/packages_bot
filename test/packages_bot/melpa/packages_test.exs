defmodule PackagesBot.Melpa.PackagesTest do
  use PackagesBot.DataCase, async: true

  alias PackagesBot.Melpa.Packages
  alias PackagesBot.Melpa.Packages.Package
  alias PackagesBot.Repo

  describe "renew_packages/0" do
    test "failed to fetch archive" do
      mock(fn
        %{method: :get, url: "https://melpa.org/archive.json"} ->
          %Tesla.Env{
            status: 500
          }
      end)

      assert Packages.renew_packages() == {:error, "Failed to fetch archive!"}
    end

    test "populate database with archive" do
      now = NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)

      expect(PackagesBot.CurrentTimeMock, :naive_now, 2, fn -> now end)

      mock(fn
        %{method: :get, url: "https://melpa.org/archive.json"} ->
          %Tesla.Env{
            status: 200,
            body: %{
              "alchemist" => %{
                "ver" => [20_180_312, 1304],
                "deps" => %{
                  "elixir-mode" => [2, 2, 5],
                  "dash" => [2, 11, 0],
                  "emacs" => [24, 4],
                  "company" => [0, 8, 0],
                  "pkg-info" => [0, 4],
                  "s" => [1, 11, 0]
                },
                "desc" => "Elixir tooling integration into Emacs",
                "type" => "tar",
                "props" => %{
                  "commit" => "6f99367511ae209f8fe2c990779764bbb4ccb6ed",
                  "keywords" => ["languages", "elixir", "elixirc", "mix", "hex", "alchemist"],
                  "authors" => ["Samuel Tonini <tonini.samuel@gmail.com>"],
                  "maintainer" => "Samuel Tonini <tonini.samuel@gmail.com>",
                  "url" => "http://www.github.com/tonini/alchemist.el"
                }
              }
            }
          }
      end)

      assert Packages.renew_packages() == {:ok, 1}

      package = Repo.get_by!(Package, name: "alchemist")
      assert package.name == "alchemist"
      assert package.description == "Elixir tooling integration into Emacs"
      assert package.total_downloads == 0
      assert package.recipe == "https://github.com/melpa/melpa/blob/master/recipes/alchemist"
      assert package.homepage == "http://www.github.com/tonini/alchemist.el"
      assert package.inserted_at == now
      assert package.updated_at == now
    end

    test "update description, recipe, homepage and updated_at on conflict" do
      persisted_package = insert(:melpa_package, name: "alchemist")

      now = NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)

      expect(PackagesBot.CurrentTimeMock, :naive_now, 2, fn -> now end)

      mock(fn
        %{method: :get, url: "https://melpa.org/archive.json"} ->
          %Tesla.Env{
            status: 200,
            body: %{
              "alchemist" => %{
                "ver" => [20_180_312, 1304],
                "deps" => %{
                  "elixir-mode" => [2, 2, 5],
                  "dash" => [2, 11, 0],
                  "emacs" => [24, 4],
                  "company" => [0, 8, 0],
                  "pkg-info" => [0, 4],
                  "s" => [1, 11, 0]
                },
                "desc" => "Elixir tooling integration into Emacs",
                "type" => "tar",
                "props" => %{
                  "commit" => "6f99367511ae209f8fe2c990779764bbb4ccb6ed",
                  "keywords" => ["languages", "elixir", "elixirc", "mix", "hex", "alchemist"],
                  "authors" => ["Samuel Tonini <tonini.samuel@gmail.com>"],
                  "maintainer" => "Samuel Tonini <tonini.samuel@gmail.com>",
                  "url" => "http://www.github.com/tonini/alchemist.el"
                }
              }
            }
          }
      end)

      assert Packages.renew_packages() == {:ok, 1}

      package = Repo.get_by!(Package, name: "alchemist")

      assert package.name == "alchemist"
      assert package.description != persisted_package.description
      assert package.description == "Elixir tooling integration into Emacs"
      assert package.total_downloads == persisted_package.total_downloads
      assert package.recipe == "https://github.com/melpa/melpa/blob/master/recipes/alchemist"
      assert package.homepage == "http://www.github.com/tonini/alchemist.el"
      assert package.inserted_at == persisted_package.inserted_at
      assert package.updated_at == now
    end

    test "missing description" do
      now = NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)

      expect(PackagesBot.CurrentTimeMock, :naive_now, 2, fn -> now end)

      mock(fn
        %{method: :get, url: "https://melpa.org/archive.json"} ->
          %Tesla.Env{
            status: 200,
            body: %{
              "alchemist" => %{
                "ver" => [20_180_312, 1304],
                "deps" => %{
                  "elixir-mode" => [2, 2, 5],
                  "dash" => [2, 11, 0],
                  "emacs" => [24, 4],
                  "company" => [0, 8, 0],
                  "pkg-info" => [0, 4],
                  "s" => [1, 11, 0]
                },
                "type" => "tar",
                "props" => %{
                  "commit" => "6f99367511ae209f8fe2c990779764bbb4ccb6ed",
                  "keywords" => ["languages", "elixir", "elixirc", "mix", "hex", "alchemist"],
                  "authors" => ["Samuel Tonini <tonini.samuel@gmail.com>"],
                  "maintainer" => "Samuel Tonini <tonini.samuel@gmail.com>",
                  "url" => "http://www.github.com/tonini/alchemist.el"
                }
              }
            }
          }
      end)

      assert Packages.renew_packages() == {:ok, 1}

      package = Repo.get_by!(Package, name: "alchemist")
      assert package.name == "alchemist"
      assert package.description == nil
      assert package.total_downloads == 0
      assert package.recipe == "https://github.com/melpa/melpa/blob/master/recipes/alchemist"
      assert package.homepage == "http://www.github.com/tonini/alchemist.el"
      assert package.inserted_at == now
      assert package.updated_at == now
    end

    test "missing homepage" do
      now = NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)

      expect(PackagesBot.CurrentTimeMock, :naive_now, 2, fn -> now end)

      mock(fn
        %{method: :get, url: "https://melpa.org/archive.json"} ->
          %Tesla.Env{
            status: 200,
            body: %{
              "alchemist" => %{
                "ver" => [20_180_312, 1304],
                "deps" => %{
                  "elixir-mode" => [2, 2, 5],
                  "dash" => [2, 11, 0],
                  "emacs" => [24, 4],
                  "company" => [0, 8, 0],
                  "pkg-info" => [0, 4],
                  "s" => [1, 11, 0]
                },
                "desc" => "Elixir tooling integration into Emacs",
                "type" => "tar",
                "props" => %{
                  "commit" => "6f99367511ae209f8fe2c990779764bbb4ccb6ed",
                  "keywords" => ["languages", "elixir", "elixirc", "mix", "hex", "alchemist"],
                  "authors" => ["Samuel Tonini <tonini.samuel@gmail.com>"],
                  "maintainer" => "Samuel Tonini <tonini.samuel@gmail.com>"
                }
              }
            }
          }
      end)

      assert Packages.renew_packages() == {:ok, 1}

      package = Repo.get_by!(Package, name: "alchemist")
      assert package.name == "alchemist"
      assert package.description == "Elixir tooling integration into Emacs"
      assert package.total_downloads == 0
      assert package.recipe == "https://github.com/melpa/melpa/blob/master/recipes/alchemist"
      assert package.homepage == nil
      assert package.inserted_at == now
      assert package.updated_at == now
    end
  end

  describe "renew_download_counts/0" do
    test "failed to fetch download counts" do
      mock(fn
        %{method: :get, url: "https://melpa.org/download_counts.json"} ->
          %Tesla.Env{
            status: 500
          }
      end)

      assert Packages.renew_download_counts() == {:error, "Failed to fetch download counts!"}
    end

    test "populate database with counts" do
      now = NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)

      expect(PackagesBot.CurrentTimeMock, :naive_now, 2, fn -> now end)

      mock(fn
        %{method: :get, url: "https://melpa.org/download_counts.json"} ->
          %Tesla.Env{
            status: 200,
            body: %{
              "alchemist" => 20_180_312
            }
          }
      end)

      assert Packages.renew_download_counts() == {:ok, 1}

      package = Repo.get_by!(Package, name: "alchemist")
      assert package.name == "alchemist"
      assert package.description == nil
      assert package.total_downloads == 20_180_312
      assert package.recipe == "https://github.com/melpa/melpa/blob/master/recipes/alchemist"
      assert package.homepage == nil
      assert package.inserted_at == now
      assert package.updated_at == now
    end

    test "update total_downloads and updated_at on conflict" do
      persisted_package = insert(:melpa_package, name: "alchemist")

      now = NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)

      expect(PackagesBot.CurrentTimeMock, :naive_now, 2, fn -> now end)

      mock(fn
        %{method: :get, url: "https://melpa.org/download_counts.json"} ->
          %Tesla.Env{
            status: 200,
            body: %{
              "alchemist" => 20_180_312
            }
          }
      end)

      assert Packages.renew_download_counts() == {:ok, 1}

      package = Repo.get_by!(Package, name: "alchemist")
      assert package.name == "alchemist"
      assert package.description == persisted_package.description
      assert package.total_downloads == 20_180_312
      assert package.recipe == "https://github.com/melpa/melpa/blob/master/recipes/alchemist"
      assert package.homepage == persisted_package.homepage
      assert package.inserted_at == persisted_package.inserted_at
      assert package.updated_at == now
    end
  end
end
