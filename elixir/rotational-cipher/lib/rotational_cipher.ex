defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist
    |> Enum.map(&skid(&1, shift))
    |> List.to_string
  end

  def skid(char, n) when char in ?a..?z and char + n > ?z do
    ?a - 1 + rem(char + n, ?z)
  end
  
  def skid(char, n) when char in ?A..?Z and char + n > ?Z do
      ?A - 1 + rem(char + n, ?Z)
  end
  
  def skid(char, n) when (char in ?A..?Z) or (char in ?a..?z) do
    char + n
  end

  def skid(char, _), do: char
  
end
