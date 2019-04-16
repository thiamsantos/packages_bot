defmodule PackagesBot.CurrentTime.Adapter do
  @callback naive_now :: NaiveDateTime.t()
end
