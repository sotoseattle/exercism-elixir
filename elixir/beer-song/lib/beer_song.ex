defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """

  def verse(number), do: give(number) <> take(number)

  defp give(0), do: "No more bottles of beer on the wall, no more bottles of beer.\n"
  defp give(1), do: "1 bottle of beer on the wall, 1 bottle of beer.\n"
  defp give(n), do: "#{n} bottles of beer on the wall, #{n} bottles of beer.\n"

  defp take(0), do: "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
  defp take(1), do: "Take it down and pass it around, no more bottles of beer on the wall.\n"
  defp take(2), do: "Take one down and pass it around, 1 bottle of beer on the wall.\n"
  defp take(n), do: "Take one down and pass it around, #{n - 1} bottles of beer on the wall.\n"

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """

  def lyrics(), do: lyrics(99..0)

  def lyrics(range) do
    range |> Enum.map(&verse/1) |> Enum.join("\n")
  end
end
