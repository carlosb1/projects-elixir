defmodule DateTimer do
  @supported_utc "Etc/UTC"

  defstruct [:timezone]

  @spec default_supported_utc() :: String
  def default_supported_utc do
    @supported_utc
  end

  @spec current_date(DateTimer) :: Date
  def current_date(date_timer) do
    date_timer.timezone |> DateTime.now!() |> DateTime.to_date()
  end

  @spec new(String) :: DateTimer
  def new(timezone) do
    %DateTimer{timezone: timezone}
  end
end
