defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """

  def match(base, candidates) do
    candidates
    |> have_same_length(base)
    |> same_ignoring_case(base)
    |> is_anagram(base)
  end

  defp have_same_length(candidates, base) do
    z = String.length(base)
    Enum.filter(candidates, &(String.length(&1) == z))
  end

  def same_ignoring_case(candidates, base) do
    Enum.filter(
      candidates,
      &(String.downcase(&1) != String.downcase(base))
    )
  end

  defp is_anagram(candidates, base) do
    Enum.filter(
      candidates,
      &anagram?(to_list(&1), to_list(base))
    )
  end

  defp anagram?([], []), do: true
  defp anagram?([], _), do: false
  defp anagram?([h | t], l2), do: anagram?(t, List.delete(l2, h))

  defp to_list(word) do
    word
    |> String.downcase()
    |> (&Regex.scan(~r/./, &1)).()
    |> List.flatten()
  end
end
