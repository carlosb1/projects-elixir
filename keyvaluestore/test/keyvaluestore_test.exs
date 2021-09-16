defmodule KeyvaluestoreTest do
  use ExUnit.Case
  doctest Keyvaluestore

  test "greets the world" do
    assert Keyvaluestore.hello() == :world
  end
end
