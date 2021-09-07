defmodule Geometry do
  def rectangle_area(a, b) do
    a * b
  end

  def area(a), do: area(a, a)
  def area(a, b), do: a * b
end

area = Geometry.rectangle_area(1, 3)

IO.puts(area)
