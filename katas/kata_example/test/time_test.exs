defmodule TimeTest do
  use ExUnit.Case

  describe("Datetimer should") do
    test "get correct current date" do
      date_timer = DateTimer.default_supported_utc() |> DateTimer.new()
      expected_date = DateTime.now!("Etc/UTC") |> DateTime.to_date()
      assert expected_date == date_timer |> DateTimer.current_date()
    end

    # TODO add wrong tests for parse cases.
  end
end
