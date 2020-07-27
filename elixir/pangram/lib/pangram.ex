defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """
  @alphabet ~w/q w e r t y u i o p a s d f g h j k l z x c v b n m/

  def pangram?(sentence) do
    letters =
      sentence
      |> String.downcase()
      |> String.graphemes()
      |> List.flatten()
      |> Enum.uniq()

    @alphabet -- letters == []
  end
end
