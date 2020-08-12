defmodule Transpose do
  @doc """
  Given an input text, output it transposed.

  Rows become columns and columns become rows. See https://en.wikipedia.org/wiki/Transpose.

  If the input has rows of different lengths, this is to be solved as follows:
    * Pad to the left with spaces.
    * Don't pad to the right.

  ## Examples
  iex> Transpose.transpose("ABC\nDE")
  "AD\nBE\nC"

  iex> Transpose.transpose("AB\nDEF")
  "AD\nBE\n F"
  """

  def transpose(input) do
    input
    |> convert_into_list_of_lists
    |> laundromat([])
  end

  defp convert_into_list_of_lists(input_string) do
    input_string
    |> String.split("\n")
    |> expand_lines_to_max_length
    |> Enum.map(&String.graphemes/1)
  end

  defp expand_lines_to_max_length(lines) do
    z = max_line_length(lines)

    Enum.map(lines, &String.pad_trailing(&1, z))
  end

  defp max_line_length(lines) do
    lines |> Enum.map(&String.length(&1)) |> Enum.max()
  end

  defp laundromat([], output) do
    output |> Enum.reverse() |> Enum.join("\n") |> String.trim_trailing()
  end

  defp laundromat(list_of_lists, output) do
    {heads, rest} = decapitate(list_of_lists, {[], []})
    laundromat(rest, [Enum.join(heads) | output])
  end

  defp decapitate([], {heads, body}), do: {Enum.reverse(heads), Enum.reverse(body)}

  defp decapitate([[] | lists], severed_tuple), do: decapitate(lists, severed_tuple)

  defp decapitate([list | lists], {heads, body}) do
    decapitate(lists, {[hd(list) | heads], [tl(list) | body]})
  end
end
