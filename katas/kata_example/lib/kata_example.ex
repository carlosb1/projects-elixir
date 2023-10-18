defmodule KataBirthday do
  @moduledoc """
  Documentation for `KataExample`.
  """

  @enforce_keys [:persistence, :smtp, :time]
  defstruct [:persistence, :smtp, :time]

  @type t :: %__MODULE__{}

  @spec new(PersistenceMemory.t(), EmailSender.t(), DateTimer.t()) :: KataBirthday.t()
  def new(persistence, smtp, time) do
    %KataBirthday{persistence: persistence, smtp: smtp, time: time}
  end

  @spec birthdays(KataBirthday.t()) :: %{birthday: Date.t(), email: <<_::152>>}
  @doc """
  Birthday function.
  """
  def birthdays(kata_birthday) do
    current_date = kata_birthday.time |> DateTimer.current_date()
    to_send = kata_birthday.persistence |> PersistenceMemory.get_by_date(current_date)

    to_send
    |> Enum.map(fn %{last_name: surname, name: name, date: date, email: email} ->
      IO.inspect(email, email: email)
      user = %{name: name, email: email}
      EmailSender.send_template(user)
    end)

    %{email: "john.doe@foobar.com", birthday: ~D[1982-10-08]}
  end
end
