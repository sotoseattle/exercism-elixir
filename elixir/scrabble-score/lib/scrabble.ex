defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """

  @tabulation %{
    ~w[A E I O U L N R S T] => 1,
    ~w[D G] => 2,
    ~w[B C M P] => 3,
    ~w[F H V W Y] => 4,
    ~w[K] => 5,
    ~w[J X] => 8,
    ~w[Q Z] => 10
  }

  def score(word) do
    word
    |> extract_letters
    |> evaluate_letters
  end

  defp extract_letters(word) do
    word
    |> (&Regex.scan(~r/[a-zA-Z]/, &1)).()
    |> List.flatten()
    |> Enum.map(&String.upcase/1)
  end

  defp evaluate_letters(char_list) do
    char_list
    |> Enum.map(&char_value(&1))
    |> Enum.sum()
  end

  defp char_value(char) do
    {_, v} = Enum.find(@tabulation, fn {x, _v} -> char in x end)
    v
  end
end
