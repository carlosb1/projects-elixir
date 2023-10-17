defmodule TimeTest do
  use ExUnit.Case
  import Mock

  describe("Datetimer should") do
    test "get correct current date" do
      date_timer = DateTimer.default_supported_utc() |> DateTimer.new()
      expected_date = DateTime.now!("Etc/UTC") |> DateTime.to_date()
      assert expected_date == date_timer |> DateTimer.current_date()
    end

    test "get mocked date" do
      with_mock DateTime, [:passthrough],
        now!: fn _timezone ->
          DateTime.from_naive!(~N[2016-05-24 13:26:08.003], "Etc/UTC")
        end do
        current_date =
          DateTimer.default_supported_utc() |> DateTimer.new() |> DateTimer.current_date()

        assert ~D[2016-05-24] == current_date
      end
    end
  end
end
