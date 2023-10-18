defmodule DateTimer do
  @supported_utc "Etc/UTC"

  defstruct [:timezone]
  @type t :: %__MODULE__{}

  @spec default_supported_utc :: <<_::56>>
  def default_supported_utc do
    @supported_utc
  end

  @spec current_date(atom | %{:timezone => binary, optional(any) => any}) :: Date.t()
  def current_date(date_timer) do
    date_timer.timezone |> DateTime.now!() |> DateTime.to_date()
  end

  @spec new(any) :: %DateTimer{timezone: any}
  def new(timezone) do
    %DateTimer{timezone: timezone}
  end
end
