defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  def search(numbers, key) do
    retriever(Tuple.to_list(numbers), key, 0) || :not_found
  end

  defp retriever([], _k, _index), do: nil
  defp retriever([k], k, index), do: {:ok, index}
  defp retriever([_], _k, _index), do: nil

  defp retriever(listo, k, index) do
    m = listo |> length() |> div(2) |> round

    if Enum.at(listo, m) == k do
      {:ok, index + m}
    else
      {a, b} = Enum.split(listo, m)
      retriever(a, k, index) || retriever(b, k, index + m)
    end
  end
end
