first_value =
  for x <- [1, 2, 3] do
    x * x
  end

values_temp = for x <- [1, 2, 3], y <- [1, 2, 3], do: [x, y, x * y]
IO.puts(values_temp)

multiplication_table =
  for x <- 1..9, y <- 1..9, x <= y, into: %{} do
    {{x, y}, x * y}
  end

values = multiplication_table[{7}]
IO.puts(values)
