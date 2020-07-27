defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  def isogram?(sentence) do
    a = chars(sentence)
    b = Enum.uniq(a)
    length(a) == length(b)
  end

  defp chars(sentence) do
    Regex.scan(~r{[a-zA-Z]}, sentence) |> List.flatten()
  end
end
