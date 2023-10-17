defmodule KataBirthday.Run do
  use Swoosh.Mailer, otp_app: :katabirthday

  def main(_args \\ []) do
    persistence = PersistenceMemory.default_file_path() |> PersistenceMemory.new()
    smtp = %EmailSender{}
    timer = DateTimer.default_supported_utc() |> DateTimer.new()

    %KataBirthday{persistence: persistence, smtp: smtp, time: timer}
    |> KataBirthday.birthdays()
    |> IO.inspect()
  end
end
