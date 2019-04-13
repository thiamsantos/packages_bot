defmodule MelpaBotTest do
  use ExUnit.Case
  doctest MelpaBot

  test "greets the world" do
    assert MelpaBot.hello() == :world
  end
end
