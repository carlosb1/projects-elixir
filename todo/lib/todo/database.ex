defmodule Todo.Database do
  use GenServer

  @db_folder "./persist"
  def start do
    GenServer.start(__MODULE__, nil, name: __MODULE__)
  end

  def store(key, data) do
    GenServer.cast(__MODULE__, {:store, key, data})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  def init(_) do
    File.mkdir_p!(@db_folder)
    {:ok, nil}
  end

  def handle_cast({:store, key, data}, state) do
    spawn(fn ->
      key
      |> file_name()
      |> File.write!(:erlang.term_to_binary(data))
    end)

    {:noreply, state}
  end

  def handle_call({:get, key}, caller, state) do
    spawn(fn ->
      data =
        case File.read(file_name(key)) do
          {:ok, contents} -> :erlang.binary_to_term(contents)
          _ -> nil
        end

      GenServer.reply(caller, data)
    end)

    {:noreply, state}
  end

  defp file_name(key) do
    Path.join(@db_folder, to_string(key))
  end
end

defmodule Todo.Database2 do
  use GenServer

  def start do
    GenServer.start(__MODULE__, nil, name: __MODULE__)
  end

  def store(key, data) do
    key
    |> choose_worker()
    |> Todo.DatabaseWorker.store(key, data)
  end

  def get(key) do
    key
    |> choose_worker()
    |> Todo.DatabaseWorker.get(key)
  end

  def init(db_folder) do
    File.mkdir_p!(db_folder)
    {:ok, start_workers()}
  end

  def handle_cast({:store, key, data}, state) do
    {:noreply, state}
  end

  def handle_call({:get, key}, caller, state) do
    {:noreply, state}
  end

  defp choose_worker(key) do
    GenServer.call(__MODULE__, {:choose_worker, key})
  end

  defp start_workers() do
    for index <- 1..3, into: %{} do
      {:ok, pid} = Todo.DatabaseWorker.start(@db_folder)
      {:index - 1, pid}
    end
  end
end

defmodule Todo.DatabaseWorker do
  use GenServer

  def start(worker_pid, db_folder) do
    GenServer.start(worker_pid, db_folder, name: __MODULE__)
  end

  def store(worker_pid, key, data) do
    GenServer.cast(worker_pid, {:store, key, data})
  end

  def get(worker_pid, key) do
    GenServer.call(worker_pid, {:get, key})
  end

  def init(db_folder) do
    {:ok, db_folder}
  end

  def handle_cast({:store, key, data}, db_folder) do
    spawn(fn ->
      key
      |> file_name()
      |> File.write!(:erlang.term_to_binary(data))
    end)

    {:noreply, db_folder}
  end

  def handle_call({:get, key}, caller, db_folder) do
    spawn(fn ->
      data =
        case File.read(file_name(key)) do
          {:ok, contents} -> :erlang.binary_to_term(contents)
          _ -> nil
        end

      GenServer.reply(caller, data)
    end)

    {:noreply, db_folder}
  end

  defp file_name(key) do
    Path.join(@db_folder, to_string(key))
  end
end
