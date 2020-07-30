defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  def convert(digits, base_a, base_b) do
    digits
    |> validate(base_a, base_b)
    |> convert_to_10_from(base_a)
    |> convert_from_10_to(base_b, [])
    |> reformat
  end

  defp validate([], _, _), do: {:error}
  defp validate(_, a, b) when a < 2 or b < 2, do: {:error}

  defp validate(digits, base_a, _) do
    cond do
      invalid_number?(digits, base_a) -> {:error}
      negative_numbers?(digits) -> {:error}
      true -> {:ok, digits}
    end
  end

  defp invalid_number?(list, b), do: length(Enum.uniq(list)) > b
  defp negative_numbers?(list), do: Enum.any?(list, &(&1 < 0))

  defp convert_to_10_from({:error}, _), do: {:error}

  defp convert_to_10_from({:ok, digits}, base) do
    z =
      digits
      |> Enum.reverse()
      |> Enum.zip(0..length(digits))
      |> Enum.reduce(0, fn {x, y}, acc ->
        acc + x * :math.pow(base, y)
      end)
      |> Kernel.trunc()

    {:ok, z}
  end

  defp convert_from_10_to({:error}, _, _), do: {:error}
  defp convert_from_10_to({:ok, 0}, _base, acc), do: {:ok, acc}

  defp convert_from_10_to({:ok, n}, base, acc) do
    convert_from_10_to(
      {:ok, div(n, base)},
      base,
      [rem(n, base) | acc]
    )
  end

  defp reformat({:error}), do: nil
  defp reformat({:ok, []}), do: [0]
  defp reformat({:ok, acc}), do: acc
end
