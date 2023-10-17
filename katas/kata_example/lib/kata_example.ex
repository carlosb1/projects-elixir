defmodule KataBirthday do
  @moduledoc """
  Documentation for `KataExample`.
  """

  @enforce_keys [:persistence, :smtp, :time]
  defstruct [:persistence, :smtp, :time]

  @doc """
  Birthday function.
  """
  def birthdays(_kata_birthday, _current_date) do
    %{email: "john.doe@foobar.com", birthday: ~D[1982-10-08]}
  end
end
