defmodule PackagesBot.CurrentTime.SystemAdapter do
  @behaviour PackagesBot.CurrentTime.Adapter

  def naive_now do
    NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)
  end
end
