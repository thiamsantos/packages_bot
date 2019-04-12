defmodule MelpaTelegramBotTest do
  use ExUnit.Case
  doctest MelpaTelegramBot

  test "greets the world" do
    assert MelpaTelegramBot.hello() == :world
  end
end
