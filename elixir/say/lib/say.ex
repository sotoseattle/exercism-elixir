defmodule Say do
  @doc """
  Translate a positive integer into English.
  """
  def in_english(n)
      when n < 0 or n > 999_999_999_999 do
    {:error, "number is out of range"}
  end

  def in_english(0), do: {:ok, "zero"}

  def in_english(number) do
    number
    |> to_list
    |> eng
    |> format
  end

  def to_list(number) do
    number
    |> Integer.to_string()
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end

  def format(:error), do: {:error}
  def format(str), do: {:ok, String.trim(str)}

  defp eng([]), do: ""
  defp eng([0 | t]), do: eng(t)

  defp eng([1]), do: "one"
  defp eng([2]), do: "two"
  defp eng([3]), do: "three"
  defp eng([4]), do: "four"
  defp eng([5]), do: "five"
  defp eng([6]), do: "six"
  defp eng([7]), do: "seven"
  defp eng([8]), do: "eight"
  defp eng([9]), do: "nine"

  defp eng([1, 0]), do: "ten"
  defp eng([1, 1]), do: "eleven"
  defp eng([1, 2]), do: "twelve"
  defp eng([1, 3]), do: "thirteen"
  defp eng([1, 5]), do: "fifteen"
  defp eng([1, n]), do: eng([n]) <> "teen"

  defp eng([2, 0]), do: "twenty"
  defp eng([3, 0]), do: "thirty"
  defp eng([4, 0]), do: "forty"
  defp eng([5, 0]), do: "fifty"
  defp eng([8, 0]), do: "eighty"
  defp eng([n, 0]), do: eng([n]) <> "ty"
  defp eng([x, y]), do: eng([x, 0]) <> "-" <> eng([y])

  defp eng([x, y, z]), do: eng([x]) <> " hundred " <> eng([y, z])

  defp eng(listo) do
    listo
    |> Enum.reverse()
    |> Enum.chunk_every(3)
    |> Enum.zip(["", " thousand ", " million ", " billion "])
    |> Enum.reverse()
    |> Enum.map(&stitch(&1))
    |> Enum.join()
  end

  defp stitch({[0, 0, 0], _}), do: ""

  defp stitch({listo, unit}) do
    listo
    |> Enum.reverse()
    |> eng()
    |> (&Kernel.<>(&1, unit)).()
  end
end
