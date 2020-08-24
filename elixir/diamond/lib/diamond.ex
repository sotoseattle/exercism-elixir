defmodule Diamond do
  def build_shape(?A), do: "A\n"
  def build_shape(letter) do
    top = cycle_letters(?A, letter - ?A, -1, "")
    bot = String.replace(top, ~r/\n.+\n$/, "") |> String.reverse()
    top <> bot <> "\n"
  end

  defp cycle_letters(c, 0, i, acc), do: acc <> row(c, 0, i)

  defp cycle_letters(char, outer_sp, inner_sp, acc) do
    cycle_letters(
      char + 1,
      outer_sp - 1,
      inner_sp + 2,
      acc <> row(char, outer_sp, inner_sp))
  end

  defp row(c, o, -1), do: "#{sp(o)}#{[c]}#{sp(o)}\n"
  defp row(c, o, i),  do: "#{sp(o)}#{[c]}#{sp(i)}#{[c]}#{sp(o)}\n"
  defp sp(n), do: String.duplicate(" ", n)
end
