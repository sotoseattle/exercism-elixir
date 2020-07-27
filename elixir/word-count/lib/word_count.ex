defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  @regexo ~r/([[:alnum:]\-]+)/u

  def count(string) do
    string
    |> String.downcase()
    |> tokenize
    |> Enum.reduce(%{}, &count/2)
  end

  defp tokenize(string) do
    @regexo
    |> Regex.scan(string)
    |> Enum.map(&List.first/1)
  end

  defp count(word, acc) do
    Map.update(acc, word, 1, &(&1 + 1))
  end
end
