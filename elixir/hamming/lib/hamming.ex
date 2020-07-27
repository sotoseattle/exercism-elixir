defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """

  def hamming_distance(strand1, strand2)
      when length(strand1) == length(strand2) do
    compare(strand1, strand2, 0)
  end

  def hamming_distance(_, _), do: {:error, "Lists must be the same length"}

  defp compare([], [], acc), do: {:ok, acc}

  defp compare([h | t1], [h | t2], acc), do: compare(t1, t2, acc)

  defp compare([_ | t1], [_ | t2], acc), do: compare(t1, t2, acc + 1)
end
