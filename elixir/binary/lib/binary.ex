defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t()) :: non_neg_integer
  def to_decimal(string) do
    string
    |> validate
    |> decompose_integers
    |> compute_value
  end

  defp validate(string) do
    if string =~ ~r/^[01]+$/, do: string, else: "0"
  end

  defp decompose_integers(string_of_digits) do
    string_of_digits
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end

  defp compute_value(list_of_ints) do
    list_of_ints
    |> list_of_powers
    |> Enum.zip(list_of_ints)
    |> reduce_to_number
  end

  defp list_of_powers(list_of_digits) do
    (0..length(list_of_digits)-1)
    |> Enum.reverse
    |> Enum.map(&:math.pow(2, &1))
  end

  defp reduce_to_number(list_of_tuples) do
    Enum.reduce(
      list_of_tuples,
      0,
      fn {digit, power}, acc ->
        acc + (digit * power)
      end)
  end
end
