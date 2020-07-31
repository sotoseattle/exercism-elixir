defmodule SecretHandshake do
  def commands(code) do
    code
    |> convert_to_binary
    |> decompose_into_factors_of_10
    |> reverse_if_10_000
    |> translate
  end

  def convert_to_binary(int) do
    Integer.digits(int, 2)
  end

  def decompose_into_factors_of_10(bin_list) do
    bin_list
    |> Enum.reverse()
    |> Enum.zip([1, 10, 100, 1000, 10_000])
    |> Enum.map(fn {x, y} -> x * y end)
    |> Enum.reject(&(&1 == 0))
    |> Enum.reverse()
  end

  def reverse_if_10_000([h | t]) when h == 10_000, do: t

  def reverse_if_10_000(listo), do: Enum.reverse(listo)

  def translate(bin_list), do: Enum.map(bin_list, &decode/1)

  def decode(1), do: "wink"
  def decode(10), do: "double blink"
  def decode(100), do: "close your eyes"
  def decode(1000), do: "jump"
end
