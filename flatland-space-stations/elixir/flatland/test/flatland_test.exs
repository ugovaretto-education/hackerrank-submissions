defmodule FlatlandTest do
  use ExUnit.Case
  doctest Flatland

  test "greets the world" do
    assert Flatland.hello() == :world
  end
end
