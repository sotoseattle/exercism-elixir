defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """

  def check_brackets(str) do
    Regex.scan(~r/[\[\]\{\}\(\)]/, str)
    |> List.flatten()
    |> xxx([])
  end

  defp xxx(["(" | t], open), do: xxx(t, ["(" | open])
  defp xxx(["[" | t], open), do: xxx(t, ["[" | open])
  defp xxx(["{" | t], open), do: xxx(t, ["{" | open])

  defp xxx([")" | t], ["(" | to]), do: xxx(t, to)
  defp xxx(["]" | t], ["[" | to]), do: xxx(t, to)
  defp xxx(["}" | t], ["{" | to]), do: xxx(t, to)

  defp xxx([], []), do: true
  defp xxx(_, _), do: false
end
