defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    input |> Map.keys() |> magic(input)
  end

  defp magic(keys, mapo, acc \\ %{})
  defp magic([], _, acc), do: acc

  defp magic([h | t], mapo, acc) do
    addo =
      mapo[h]
      |> Enum.map(fn v -> {String.downcase(v), h} end)
      |> Map.new()

    magic(t, mapo, Map.merge(acc, addo))
  end
end
