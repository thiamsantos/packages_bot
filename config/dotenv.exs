unless Code.ensure_loaded?(Dotenv) do
  defmodule Dotenv do
    @key_value_delimeter "="

    def auto_load do
      unless ci_environment?() do
        current_env()
        |> filenames()
        |> Enum.map(&absolute_path/1)
        |> Enum.filter(&File.exists?/1)
        |> Enum.flat_map(&get_pairs/1)
        |> load_env()
      end
    end

    defp filenames(current_env) do
      [".env", ".env.local", ".env.#{current_env}", ".env.local.#{current_env}"]
    end

    defp current_env do
      Mix.env()
      |> to_string()
      |> String.downcase()
    end

    defp absolute_path(filename) do
      __ENV__.file()
      |> Path.dirname()
      |> Path.join("..")
      |> Path.join(filename)
      |> Path.expand()
    end

    defp get_pairs(filename) do
      filename
      |> File.read!()
      |> String.split("\n")
      |> Enum.reject(&blank_entry?/1)
      |> Enum.reject(&comment_entry?/1)
      |> Enum.map(&parse_line/1)
    end

    defp ci_environment? do
      System.get_env("CI") != nil
    end

    defp parse_line(line) do
      [key, value] =
        line
        |> String.trim()
        |> String.split(@key_value_delimeter, parts: 2)

      {key, parse_value(value)}
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
      pairs
      |> Enum.filter(fn {key, _value} -> is_nil(System.get_env(key)) end)
      |> Enum.each(fn {key, value} ->
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
end

Dotenv.auto_load()
