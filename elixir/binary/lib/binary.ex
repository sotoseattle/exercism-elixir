defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t()) :: non_neg_integer
  def to_decimal(string) do
    string
    |> validate
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> Enum.reverse()
    |> Enum.zip(Stream.iterate(0, &(&1 + 1)))
    |> Enum.reduce(0, fn {x, y}, acc ->
      acc + x * :math.pow(2, y)
    end)
  end

  defp validate(string) do
    if string =~ ~r/^[01]+$/, do: string, else: "0"
  end
end
