unless Code.ensure_compiled?(Dotenv) do
  defmodule Dotenv do
    @key_value_delimeter "="

    def auto_load do
      unless ci_environment?() do
        current_env()
        |> filenames()
        |> Enum.map(&absolute_path/1)
        |> Enum.filter(&File.exists?/1)
        |> Enum.each(&load_file/1)
      end
    end

    def fetch_env!(key) do
      case System.get_env(key) do
        nil ->
          raise ArgumentError,
                "Could not fetch environment #{key} because configuration #{key} was not set"

        value ->
          value
      end
    end

    def fetch_integer_env!(key) do
      key
      |> fetch_env!()
      |> String.to_integer()
    end

    defp filenames(current_env) do
      [".env", ".env.local", ".env.#{current_env}"]
    end

    defp current_env do
      Mix.env()
      |> to_string()
      |> String.downcase()
    end

    defp ci_environment? do
      System.get_env("CI") != nil
    end

    defp absolute_path(filename) do
      __ENV__.file()
      |> Path.dirname()
      |> Path.join("..")
      |> Path.join(filename)
      |> Path.expand()
    end

    defp load_file(content) do
      content
      |> File.read!()
      |> get_pairs()
      |> load_env()
    end

    defp get_pairs(content) do
      content
      |> String.split("\n")
      |> Enum.reject(&blank_entry?/1)
      |> Enum.reject(&comment_entry?/1)
      |> Enum.map(&parse_line/1)
    end

    defp parse_line(line) do
      [key, value] =
        line
        |> String.trim()
        |> String.split(@key_value_delimeter, parts: 2)

      [key, parse_value(value)]
    end

    defp parse_value(value) do
      if String.starts_with?(value, "\"") do
        unquote_string(value)
      else
        value |> String.split("#", parts: 2) |> List.first()
      end
    end

    defp unquote_string(value) do
      value
      |> String.split(~r{(?<!\\)"}, parts: 3)
      |> Enum.drop(1)
      |> List.first()
      |> String.replace(~r{\\"}, ~S("))
    end

    defp load_env(pairs) when is_list(pairs) do
      Enum.each(pairs, fn [key, value] ->
        System.put_env(String.upcase(key), value)
      end)
    end

    defp blank_entry?(string) do
      string == ""
    end

    defp comment_entry?(string) do
      String.match?(string, ~r(^\s*#))
    end
  end

  Dotenv.auto_load()
end
