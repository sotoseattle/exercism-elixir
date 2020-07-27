defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """

  def compare(a, a), do: :equal

  def compare(a, b) do
    cond do
      sublist?(a, b) -> :sublist
      sublist?(b, a) -> :superlist
      true -> :unequal
    end
  end

  defp sublist?(a, b) do
    cond do
      recurr(a, b) == :match -> true
      recurr(a, b) == :stop -> sublist?(a, tail(b))
      true -> false
    end
  end

  defp tail([_h | t]), do: t

  defp recurr([], _), do: :match
  defp recurr(_, []), do: false
  defp recurr([h | t1], [h | t2]), do: recurr(t1, t2)
  defp recurr(_, _), do: :stop
end
