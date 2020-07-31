defmodule RotationalCipher do
  def rotate(text, shift) do
    text
    |> String.to_charlist()
    |> Enum.map(&skid(&1, shift))
    |> List.to_string()
  end

  defguardp is_lowcase(c) when c in ?a..?z
  defguardp is_upcase(c) when c in ?A..?Z
  defguardp lies_beyond_z?(c, n) when is_lowcase(c) and c + n > ?z
  defguardp lies_beyond_Z?(c, n) when is_upcase(c) and c + n > ?Z

  defp skid(char, n) when lies_beyond_z?(char, n),
    do: ?a - 1 + rem(char + n, ?z)

  defp skid(char, n) when lies_beyond_Z?(char, n),
    do: ?A - 1 + rem(char + n, ?Z)

  defp skid(char, n) when is_upcase(char) or is_lowcase(char),
    do: char + n

  defp skid(char, _), do: char
end
