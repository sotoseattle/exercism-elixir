defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, asrepse all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(""), do: ""
  def encode(string) do
    string
    |> String.graphemes
    |> enc
  end

  defp enc(listo, char \\ "", reps \\ 1, sol \\ "")
  defp enc([], char, reps, sol), do: sol <> formato(reps, char)
  defp enc([h|t], h, reps, sol), do: enc(t, h, reps + 1, sol)
  defp enc([h|t], char, reps, sol), do: enc(t, h, 1, sol <> formato(reps, char)) 

  defp formato(1, b), do: b
  defp formato(a, b), do: "#{a}#{b}"

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.scan(~r{(\d*)([\w\s])}, string)
    |> Enum.map(&dec(&1))
    |> Enum.join
  end

  def dec([_, "", c]), do: c
  def dec([_, n, c]), do: String.duplicate(c, String.to_integer(n))

end
