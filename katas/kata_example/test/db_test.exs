defmodule DbTest do
  use ExUnit.Case

  @filepath "./resources/data.csv"

  @expected_encoded_data [
    %{
      date: ~D[1982-10-08],
      email: "john.doe@foobar.com",
      last_name: "Doe",
      name: "John"
    },
    %{
      date: ~D[1975-09-11],
      email: "mary.ann@foobar.com",
      last_name: "Ann",
      name: "Mary"
    }
  ]

  describe("Persistence memory should") do
    test "load data from a constructor" do
      persistence = PersistenceMemory.new(@filepath)
      assert @expected_encoded_data == persistence.data
    end

    test "get data by filter correctly" do
      persistence = PersistenceMemory.new(@filepath)

      day_to_check = ~D[2023-09-11]
      found = persistence |> PersistenceMemory.get_by_date(day_to_check)

      expected_found = [@expected_encoded_data |> Enum.at(1)]
      assert expected_found == found
    end

    test "get data by filter icorrectly" do
      persistence = PersistenceMemory.new(@filepath)
      day_to_check = ~D[2023-09-12]
      found = persistence |> PersistenceMemory.get_by_date(day_to_check)
      assert [] == found
    end
  end
end
