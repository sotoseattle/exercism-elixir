defmodule SecretHandshake do
  def commands(code) do
    code
    |> convert_to_binary
    |> decompose_into_factors_of_10
    |> reverse_if_10_000
    |> translate
  end

  defp convert_to_binary(int) do
    Integer.digits(int, 2)
  end

  defp decompose_into_factors_of_10(bin_list) do
    bin_list
    |> Enum.reverse()
    |> Enum.zip([1, 10, 100, 1000, 10_000])
    |> Enum.map(fn {x, y} -> x * y end)
    |> Enum.reject(&(&1 == 0))
    |> Enum.reverse()
  end

  defp reverse_if_10_000([10_000 | t]), do: Enum.reverse(t)
  defp reverse_if_10_000(list), do: list

  defp translate(bin_list) do
    bin_list
    |> Enum.map(&decode/1)
    |> Enum.reverse()
  end

  defp decode(1), do: "wink"
  defp decode(10), do: "double blink"
  defp decode(100), do: "close your eyes"
  defp decode(1000), do: "jump"
end
