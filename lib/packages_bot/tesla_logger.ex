defmodule PackagesBot.TeslaLogger do
  @behaviour Tesla.Middleware

  require Logger

  def call(env, next, opts) do
    {time, response} = :timer.tc(Tesla, :run, [env, next])

    Logger.info(
      "[#{format_marker(opts)}] #{format_method(env)} #{format_url(env, opts)} -> #{format_status(response)} (#{format_time(time)})"
    )

    response
  end

  defp format_method(env) do
    env.method |> to_string() |> String.upcase()
  end

  defp format_url(env, opts) do
    if filter_url = Keyword.get(opts, :filter_url) do
      {pattern, replace} = filter_url
      String.replace(env.url, pattern, replace)
    else
      env.url
    end
  end

  defp format_status({:ok, env}), do: to_string(env.status)
  defp format_status({:error, reason}), do: "error: #{inspect(reason)}"

  defp format_time(time) do
    "#{:io_lib.format("~.3f", [time / 1000])} ms"
  end

  defp format_marker(opts) do
    if marker = Keyword.get(opts, :marker) do
      marker
    else
      "HTTP"
    end
  end
end
