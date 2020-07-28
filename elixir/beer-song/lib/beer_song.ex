defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """

  def verse(number), do: give(number) <> take(number)

  defp give(0), do: "No more bottles of beer on the wall, no more bottles of beer.\n"
  defp give(n), do: "#{bottles(n)} of beer on the wall, #{bottles(n)} of beer.\n"

  defp take(0), do: "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
  defp take(1), do: "Take it down and pass it around, no more bottles of beer on the wall.\n"
  defp take(n), do: "Take one down and pass it around, #{bottles(n - 1)} of beer on the wall.\n"

  defp bottles(1), do: "1 bottle"
  defp bottles(n), do: "#{n} bottles"

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """

  def lyrics(), do: lyrics(99..0)

  def lyrics(range) do
    range |> Enum.map(&verse/1) |> Enum.join("\n")
  end
end
