defmodule PerfectNumbers do
  def classify(n) when n < 1 or not is_integer(n), do:
    {:error, "Classification is only possible for natural numbers."}

  def classify(number) do
    number
    |> aliquot_sum
    |> categorize(number)
  end

  defp aliquot_sum(number), do: factors(number, 1, []) |> Enum.sum

  defp factors(n, n, acc), do: acc
  defp factors(n, x, acc) when rem(n, x) == 0, do: factors(n, x + 1, [x | acc])
  defp factors(n, x, acc), do: factors(n, x + 1, acc)

  defp categorize(n, n), do: {:ok, :perfect}
  defp categorize(ali, n) when ali > n, do: {:ok, :abundant}
  defp categorize(_, _), do: {:ok, :deficient}
end
