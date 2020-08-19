defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(raw_map) do
    reverse_map(
      %{},
      Map.keys(raw_map),
      raw_map
    )
  end

  defp reverse_map(acc, [], _), do: acc
  defp reverse_map(acc, [key | unprocessed_keys], raw_map) do
    raw_map
    |> reverse_map_by_key(key)
    |> Map.merge(acc)
    |> reverse_map(unprocessed_keys, raw_map)
  end

  defp reverse_map_by_key(input_map, key) do
    input_map[key]
      |> Enum.map(&reverse_tuple(&1, key))
      |> Map.new()
  end

  defp reverse_tuple(value, key) do
    {String.downcase(value), key}
  end
end
