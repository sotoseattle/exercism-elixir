defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """

  def verse(0) do
    """
    No more bottles of beer on the wall, no more bottles of beer.
    Go to the store and buy some more, 99 bottles of beer on the wall.
    """
  end

  def verse(n) do
    """
    #{bottles(n)} of beer on the wall, #{bottles(n)} of beer.
    Take #{one_it(n - 1)} down and pass it around, #{bottles(n - 1)} of beer on the wall.
    """
  end

  defp bottles(0), do: "no more bottles"
  defp bottles(1), do: "1 bottle"
  defp bottles(n), do: "#{n} bottles"

  defp one_it(0), do: "it"
  defp one_it(_), do: "one"

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """

  def lyrics(range \\ 99..0) do
    range |> Enum.map(&verse/1) |> Enum.join("\n")
  end
end
