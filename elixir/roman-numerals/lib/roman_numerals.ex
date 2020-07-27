defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @order %{
    1 => %{mag: "I", mid: "V"},
    10 => %{mag: "X", mid: "L"},
    100 => %{mag: "C", mid: "D"},
    1000 => %{mag: "M", mid: ""}
  }
  @sorted_order ~w/I X C M/

  def numeral(n) do
    n
    |> convert_to_list()
    |> parse
    |> reformat
  end

  defp convert_to_list(int) do
    int
    |> Integer.to_string()
    |> String.graphemes()
    |> Enum.map(&String.to_integer(&1))
  end

  defp parse(list_of_integers) do
    list_of_integers
    |> Enum.reverse()
    |> Enum.zip([1, 10, 100, 1000])
    |> Enum.map(fn {n, mag} ->
      @order |> Map.get(mag) |> Map.put(:n, n)
    end)
    |> Enum.map(&translate/1)
  end

  defp reformat(list) do
    list |> Enum.reverse() |> Enum.join()
  end

  defp translate(%{n: 4, mag: mag, mid: mid}), do: mag <> mid

  defp translate(%{n: n, mag: mag, mid: mid}) when n >= 5 and n <= 8 do
    mid <> String.duplicate(mag, n - 5)
  end

  defp translate(%{n: 9, mag: mag}), do: mag <> next_om(mag)

  defp translate(%{n: n, mag: mag}), do: String.duplicate(mag, n)

  def next_om(o) do
    {n, _} = Enum.find(@order, fn {x, _} -> @order[x].mag == o end)
    @order[n * 10].mag
  end
end
