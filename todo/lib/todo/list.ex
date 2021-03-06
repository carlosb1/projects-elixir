defmodule MultiDict do
  def new(), do: %{}

  def add(dict, key, value) do
    Map.update(dict, key, [value], &[value | &1])
  end

  def get(dict, key) do
    Map.get(dict, key, [])
  end
end

defmodule Todo.List do
  defstruct auto_id: 1, entries: %{}
  def new(), do: %Todo.List{}

  def new(entries \\ []) do
    Enum.reduce(entries, %Todo.List{}, fn entry, todo_list_acc ->
      add_entry(todo_list_acc, entry)
    end)

    # Enum.reduce(entries, %TodoList(), &add_entry(&2, &1))
  end

  def add_entry(todo_list, entry) do
    IO.inspect(label: "before")
    IO.inspect(label: entry)
    entry = Map.put(entry, :id, todo_list.auto_id)
    new_entries = Map.put(todo_list.entries, todo_list.auto_id, entry)
    %Todo.List{todo_list | entries: new_entries, auto_id: todo_list.auto_id + 1}
  end

  def entries(todo_list, date) do
    todo_list.entries
    |> Stream.filter(fn {_, entry} -> entry.date == date end)
    |> Enum.map(fn {_, entry} -> entry end)
  end

  def update_entry(todo_list, entry_id, updater_fun) do
    case Map.fetch(todo_list.entries, entry_id) do
      :error ->
        todo_list

      {:ok, old_entry} ->
        old_entry_id = old_entry.id
        new_entry = %{id: ^old_entry_id} = updater_fun.(old_entry)
        new_entry = updater_fun.(old_entry)
        new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
        %Todo.List{todo_list | entries: new_entries}
    end
  end

  def update_entry(todo_list, %{} = new_entry) do
    update_entry(todo_list, new_entry.id, fn _ -> new_entry end)
  end
end

defmodule Todo.List.CsvImporter do
  @spec import(binary()) :: TodoList
  def import(name_file) do
    content = File.read!(name_file)

    todolists =
      content
      |> String.split("\n", trim: true)
      |> Enum.map(fn x -> String.split(x, ",", trim: true) end)
      |> Enum.map(fn todo ->
        %{
          date:
            String.split(Enum.at(todo, 0), "/")
            |> (fn [yyyy, mm, dd] -> Date.from_iso8601!("#{yyyy}-#{mm}-#{dd}") end).(),
          title: Enum.at(todo, 1)
        }
      end)

    Todo.List.new(todolists)
  end
end
