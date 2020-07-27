defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """

  def to(limit, factors) do
    0..(limit - 1)
    |> Enum.to_list()
    |> Enum.filter(&divisible?(&1, factors))
    |> Enum.sum()
  end

  defp divisible?(n, factors) do
    Enum.any?(factors, fn x -> rem(n, x) == 0 end)
  end
end
