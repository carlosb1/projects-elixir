defmodule DatabaseServer do
  defp loop do
    receive do
      {:run_query, caller, query_def} ->
        send(caller, {:query_result, run_query(query_def)})
        # code
    end

    loop()
  end

  defp run_query(query_def) do
    Process.sleep(2000)
    "#{query_def} result"
  end
end
