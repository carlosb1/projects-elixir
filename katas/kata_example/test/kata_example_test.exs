defmodule KataBirthdayTest do
  use ExUnit.Case
  doctest KataBirthday

  import Mock

  @filepath "./resources/data.csv"

  test "should find birthday greetings for an input" do
    with_mocks([
      {DateTime, [:passthrough],
       now!: fn _timezone ->
         DateTime.from_naive!(~N[2016-09-11 13:26:08.003], "Etc/UTC")
       end},
      {EmailSender, [], send_template: fn _user -> IO.inspect("called") end}
    ]) do
      persistence = PersistenceMemory.new(@filepath)
      smtp = %EmailSender{}
      timer = DateTimer.default_supported_utc() |> DateTimer.new()

      assert %KataBirthday{persistence: persistence, smtp: smtp, time: timer}
             |> KataBirthday.birthdays() == %{
               email: "john.doe@foobar.com",
               birthday: ~D[1982-10-08]
             }
    end
  end
end
