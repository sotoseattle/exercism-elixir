defmodule RotationalCipher do
  def rotate(text, shift) do
    text
    |> String.to_charlist()
    |> Enum.map(&skid(&1, shift))
    |> List.to_string()
  end

  defp skid(char, n) when char in ?a..?z, do: stream(?a..?z, char, n)

  defp skid(char, n) when char in ?A..?Z, do: stream(?A..?Z, char, n)

  defp skid(char, _n), do: char

  defp stream(range, char, n) do
    range
    |> Stream.cycle()
    |> Stream.drop(char + n - start_of(range))
    |> Enum.take(1)
  end

  defp start_of(range), do: range |> Enum.to_list() |> hd
end
