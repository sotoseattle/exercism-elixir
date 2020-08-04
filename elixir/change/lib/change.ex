defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(coins, target) do
    coins
    |> xxx(target, [])
    |> format
  end

  defp xxx([], target, _acc) when target != 0, do: nil

  defp xxx(_, 0, acc), do: Enum.reverse(acc)

  defp xxx([h | t] = coins, target, acc) when h <= target do
    xxx(t, target, acc) || xxx(coins, target - h, [h | acc])
  end

  defp xxx([_h | t], target, acc) do
    xxx(t, target, acc)
  end

  defp format(nil), do: {:error, "cannot change"}
  defp format(list), do: {:ok, list}
end
