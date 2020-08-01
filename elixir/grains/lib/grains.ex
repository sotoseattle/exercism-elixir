defmodule Grains do
  def square(number) when number > 0 and number < 65,
    do: {:ok, sqr(number)}

  def square(_),
    do: {:error, "The requested square must be between 1 and 64 (inclusive)"}

  def total,
    do: {:ok, Enum.reduce(1..64, 0, fn x, acc -> acc + sqr(x) end)}

  defp sqr(1), do: 1
  defp sqr(n), do: 2 * sqr(n - 1)
end
