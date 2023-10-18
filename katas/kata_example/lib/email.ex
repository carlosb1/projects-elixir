import Swoosh.Email

defmodule EmailSender do
  defstruct []
  @type t :: %__MODULE__{}

  def send_template(user) do
    new()
    |> to({user.name, user.email})
    |> from({"your company", "boss@yourcompany.com"})
    |> subject("Happy Birthday!")
    |> html_body("<h1>Happy Birthday #{user.name}</h1>")
  end
end
