defmodule BoubaApiTest do
  use ExUnit.Case
  doctest BoubaApi

  test "greets the world" do
    assert BoubaApi.hello() == :world
  end
end
