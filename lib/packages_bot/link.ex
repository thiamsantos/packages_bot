defmodule PackagesBot.Link do
  @derive Jason.Encoder
  defstruct [:text, :url]
end
