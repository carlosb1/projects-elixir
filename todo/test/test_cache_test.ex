defmodule TodoCacheTest do
  use ExUnit.Case

  test "to-do operations" do
    {:ok, :cache} = Todo.Cache.start()
    alice = Todo.Cache.server_process(cache, "alice")
    Todo.Server.add_entry(alice, %{alice, %{date: ~D[2018-12-19], title: "Dentist" }})
    entries = Todo.Server.entries(alice, ~D[2018-12-19])
    assert[%{date: ~D[2018-12-19], title: "Dentist"}] = entries
  end
end
