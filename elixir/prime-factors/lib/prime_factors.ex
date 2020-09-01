defmodule PrimeFactors do
  def factors_for(number) do
    fact_u(number, 2, [])
  end

  defp fact_u(number, factor, acc) when factor > number, do: Enum.reverse(acc)

  defp fact_u(number, factor, acc) when rem(number, factor) == 0 do
    fact_u(div(number, factor), factor, [factor | acc])
  end

  defp fact_u(number, factor, acc) do
    fact_u(number, factor + 1, acc)
  end
end
