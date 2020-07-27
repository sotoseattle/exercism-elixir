defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  def flatten(list, acc \\ [])

  def flatten([], acc), do: acc

  def flatten([h | t], acc) do
    flatten(t, flatten(h, acc))
  end

  def flatten(nil, acc), do: acc
  def flatten(n, acc), do: acc ++ [n]
end
