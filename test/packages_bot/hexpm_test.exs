defmodule PackagesBot.HexpmTest do
  use PackagesBot.DataCase, async: true

  alias PackagesBot.{Hexpm, Link, Package}
  alias PackagesBot.Support.Fixtures

  describe "search_package/1" do
    test "should return packages from api" do
      mock(fn
        %{
          method: :get,
          url: "https://hex.pm/api/packages",
          query: [search: "mutex", sort: "downloads"]
        } ->
          %Tesla.Env{
            status: 200,
            body: Fixtures.hexpm("mutex")
          }
      end)

      expected = [
        %Package{
          id: "hexpm:redis_mutex",
          name: "redis_mutex",
          description:
            "RedisMutex is a library for creating a Redis lock for a single Redis instance.",
          total_downloads: 15_142,
          links: [
            %Link{
              text: "Repository",
              url: "https://github.com/podium/redis_mutex"
            },
            %Link{
              text: "Package",
              url: "https://hex.pm/packages/redis_mutex"
            }
          ]
        },
        %Package{
          id: "hexpm:mutex",
          name: "mutex",
          description:
            "This package implements a simple mutex as a GenServer. It allows to await\nlocked keys and handles locking multiple keys without deadlocks.",
          total_downloads: 10_559,
          links: [
            %Link{
              text: "Repository",
              url: "https://github.com/niahoo/mutex"
            },
            %Link{
              text: "Package",
              url: "https://hex.pm/packages/mutex"
            }
          ]
        },
        %Package{
          id: "hexpm:red_mutex",
          name: "red_mutex",
          description: "Redlock (Redis Distributed Lock) implementation",
          total_downloads: 40,
          links: [
            %Link{
              text: "Repository",
              url: "https://github.com/thiamsantos/red_mutex"
            },
            %Link{
              text: "Package",
              url: "https://hex.pm/packages/red_mutex"
            }
          ]
        }
      ]

      assert {:ok, actual} = Hexpm.search_package("mutex")
      assert actual == expected
    end

    test "failed to fetch packages" do
      mock(fn
        %{
          method: :get,
          url: "https://hex.pm/api/packages",
          query: [search: "mutex", sort: "downloads"]
        } ->
          %Tesla.Env{status: 500}
      end)

      assert Hexpm.search_package("mutex") == {:error, "Failed to fetch packages!"}
    end

    test "limit 5 packages" do
      mock(fn
        %{
          method: :get,
          url: "https://hex.pm/api/packages",
          query: [search: "phoenix", sort: "downloads"]
        } ->
          %Tesla.Env{
            status: 200,
            body: Fixtures.hexpm("phoenix")
          }
      end)

      assert {:ok, packages} = Hexpm.search_package("phoenix")

      assert length(packages) == 5
    end

    test "empty return" do
      mock(fn
        %{
          method: :get,
          url: "https://hex.pm/api/packages",
          query: [search: "marginalia", sort: "downloads"]
        } ->
          %Tesla.Env{status: 200, body: []}
      end)

      assert Hexpm.search_package("marginalia") == {:ok, []}
    end

    test "support bitbucket" do
      mock(fn
        %{
          method: :get,
          url: "https://hex.pm/api/packages",
          query: [search: "mutex", sort: "downloads"]
        } ->
          %Tesla.Env{
            status: 200,
            body: Fixtures.hexpm("mutex_bitbucket")
          }
      end)

      expected = [
        %Package{
          id: "hexpm:mutex",
          name: "mutex",
          description:
            "This package implements a simple mutex as a GenServer. It allows to await\nlocked keys and handles locking multiple keys without deadlocks.",
          total_downloads: 10_559,
          links: [
            %Link{
              text: "Repository",
              url: "https://bitbucket.org/niahoo/mutex"
            },
            %Link{
              text: "Package",
              url: "https://hex.pm/packages/mutex"
            }
          ]
        },
        %Package{
          id: "hexpm:red_mutex",
          name: "red_mutex",
          description: "Redlock (Redis Distributed Lock) implementation",
          total_downloads: 40,
          links: [
            %Link{
              text: "Repository",
              url: "https://bitbucket.org/thiamsantos/red_mutex"
            },
            %Link{
              text: "Package",
              url: "https://hex.pm/packages/red_mutex"
            }
          ]
        }
      ]

      assert {:ok, actual} = Hexpm.search_package("mutex")
      assert actual == expected
    end

    test "support gitlab" do
      mock(fn
        %{
          method: :get,
          url: "https://hex.pm/api/packages",
          query: [search: "mutex", sort: "downloads"]
        } ->
          %Tesla.Env{
            status: 200,
            body: Fixtures.hexpm("mutex_gitlab")
          }
      end)

      expected = [
        %Package{
          id: "hexpm:mutex",
          name: "mutex",
          description:
            "This package implements a simple mutex as a GenServer. It allows to await\nlocked keys and handles locking multiple keys without deadlocks.",
          total_downloads: 10_559,
          links: [
            %Link{
              text: "Repository",
              url: "https://gitlab.com/niahoo/mutex"
            },
            %Link{
              text: "Package",
              url: "https://hex.pm/packages/mutex"
            }
          ]
        },
        %Package{
          id: "hexpm:red_mutex",
          name: "red_mutex",
          description: "Redlock (Redis Distributed Lock) implementation",
          total_downloads: 40,
          links: [
            %Link{
              text: "Repository",
              url: "https://gitlab.com/thiamsantos/red_mutex"
            },
            %Link{
              text: "Package",
              url: "https://hex.pm/packages/red_mutex"
            }
          ]
        }
      ]

      assert {:ok, actual} = Hexpm.search_package("mutex")
      assert actual == expected
    end
  end
end
