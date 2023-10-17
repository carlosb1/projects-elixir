defmodule KataBirthdayTest do
  use ExUnit.Case
  doctest KataBirthday

  @filepath "./resources/data.csv"
  @current_date ~D[2000-09-11]

  test "should find birthday greetings for an input" do
    persistence = PersistenceMemory.new(@filepath)
    smtp = %EmailSender{}
    timer = DateTimer.default_supported_utc() |> DateTimer.new()

    assert %KataBirthday{persistence: persistence, smtp: smtp, time: timer}
           |> KataBirthday.birthdays(@current_date) == %{
             email: "john.doe@foobar.com",
             birthday: ~D[1982-10-08]
           }
  end
end
