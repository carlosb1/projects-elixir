defmodule PersistenceMemory do
  defstruct [:data]
  @type t :: %__MODULE__{}

  @spec get_by_date(atom | %{:data => any, optional(any) => any}, any) :: list
  def get_by_date(persistence, target_date) do
    persistence.data
    |> Enum.filter(fn value ->
      value[:date].month == target_date.month and
        value[:date].day == target_date.day
    end)
  end

  @spec to_date(String) :: Date
  defp to_date(str_date) do
    [yyyy, mm, dd] = String.split(str_date, "/")
    Date.from_iso8601("#{yyyy}-#{mm}-#{dd}")
  end

  @spec new(
          binary
          | maybe_improper_list(
              binary | maybe_improper_list(any, binary | []) | char,
              binary | []
            )
        ) :: PersistenceMemory.t()
  def new(filepath) do
    data =
      File.read!(filepath)
      |> String.split("\n")
      |> Enum.reject(fn v -> v == "" end)
      |> Enum.drop(1)
      |> Enum.reduce([], fn line, acc ->
        [surname, name, date, email] = String.split(line, ",")
        date = date |> String.trim_leading()
        name = name |> String.trim()
        surname = surname |> String.trim()
        email = email |> String.trim()

        with {:ok, parsed_date} <- to_date(date) do
          acc ++ [%{last_name: surname, name: name, date: parsed_date, email: email}]
        else
          _ -> acc
        end
      end)

    %PersistenceMemory{data: data}
  end

  @filepath "./resources/data.csv"
  def default_file_path() do
    @filepath
  end
end
