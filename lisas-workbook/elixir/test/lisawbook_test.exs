defmodule LisawbookTest do
  use ExUnit.Case
  doctest Lisawbook

  test "greets the world" do
    assert Lisawbook.hello() == :world
  end
end
