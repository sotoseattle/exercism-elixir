defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) do
    s
    |> String.graphemes
    |> itero(size)
  end

  def itero(listo, z) when z < 1 or z > length(listo), do: []
  def itero([_h|t] = listo, z) do
    [ slicer(listo, z, []) | itero(t, z)]
  end

  def slicer(_listo, 0, acc), do: Enum.join(acc)
  def slicer([h|t], n, acc) do
    slicer(t, n-1, acc ++ [h])
  end
end
