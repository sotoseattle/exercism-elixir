defmodule Triangle do
  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """

  def kind(a, b, c) do
    {:ok, [a, b, c]}
    |> check_lengths
    |> check_legality
    |> type
  end

  defp check_lengths({:ok, [a, b, c]})
       when a <= 0 or b <= 0 or c <= 0 do
    {:error, "all side lengths must be positive"}
  end

  defp check_lengths(o_o), do: o_o

  defp check_legality({:ok, [a, b, c]})
       when a + b <= c or a + c <= b or b + c <= a do
    {:error, "side lengths violate triangle inequality"}
  end

  defp check_legality(o_o), do: o_o

  defp type({:error, _} = o_o), do: o_o

  defp type({:ok, [a, a, a]}), do: {:ok, :equilateral}
  defp type({:ok, [_, b, b]}), do: {:ok, :isosceles}
  defp type({:ok, [b, _, b]}), do: {:ok, :isosceles}
  defp type({:ok, [b, b, _]}), do: {:ok, :isosceles}
  defp type({:ok, [_, _, _]}), do: {:ok, :scalene}
end
