defmodule Hexadecimal do
  def to_decimal(hex) do
    hex
    |> hex_char_conversion
    |> validate
    |> recursive_computation(0)
  end

  defp hex_char_conversion(str_o_hex) do
    str_o_hex
    |> String.graphemes
    |> Enum.map(&convert_to_dec(&1))
  end

  defp validate(array_o_hex) do
    (Enum.all?(array_o_hex, &is_integer(&1)) && array_o_hex) ||
    :error
  end

  defp recursive_computation(:error, _acc), do: 0
  defp recursive_computation([], acc), do: acc
  defp recursive_computation([h | t], acc) do
    z = h * :math.pow(16, length(t))
    recursive_computation(t, acc + z)
  end

  defp convert_to_dec(char)
    when char in ~w"0 1 2 3 4 5 6 7 8 9" do
    String.to_integer(char)
  end
  defp convert_to_dec(char) do
    %{"A" => 10, "B" => 11, "C" => 12,
      "D" => 13, "E" => 14, "F" => 15
     }[String.upcase(char)]
  end
end
