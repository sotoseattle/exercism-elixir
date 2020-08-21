defmodule Luhn do
  def valid?(number) do
    number
    |> is_valid_string?
    |> passes_formula_test?
  end

  defp is_valid_string?(string) do
    string
      |> remove_spaces
      |> check_numbers
  end

  defp remove_spaces(s), do: String.replace(s, ~r/\s+/, "")
  defp check_numbers(s), do: Regex.match?(~r/^[0-9]{2,}$/, s) && s

  defp passes_formula_test?(false), do: false
  defp passes_formula_test?(list) do
    list
    |> String.graphemes
    |> Enum.map(&String.to_integer/1)
    |> Enum.reverse
    |> Enum.zip(Stream.cycle([0, 1]))
    |> Enum.map(&compute_digit/1)
    |> Enum.sum
    |> (&(rem(&1, 10) == 0)).()
  end

  defp compute_digit({k, 0}), do: k
  defp compute_digit({9, _}), do: 9
  defp compute_digit({k, _}), do: rem(2 * k, 9)
end
