defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """

  #     MP  W  D  L  P
  @wino [1, 1, 0, 0, 3]
  @loss [1, 0, 0, 1, 0]
  @draw [1, 0, 1, 0, 1]

  def tally(input) do
    input
    |> parse
    |> reduce
    |> sort
    |> format
  end

  defp parse(input) do
    input
    |> Enum.map(&String.split(&1, ";"))
    |> Enum.map(&record(&1))
    |> List.flatten()
  end

  defp record([team1, team2, "win"]), do: [{team1, @wino}, {team2, @loss}]
  defp record([team1, team2, "loss"]), do: [{team1, @loss}, {team2, @wino}]
  defp record([team1, team2, "draw"]), do: [{team1, @draw}, {team2, @draw}]
  defp record(_), do: []

  defp reduce(tupple_list) do
    Enum.reduce(tupple_list, %{}, fn {k, v}, acc ->
      if Map.has_key?(acc, k) do
        Map.put(acc, k, suma(acc[k], v, []))
      else
        Map.put(acc, k, v)
      end
    end)
  end

  defp suma([], [], acc), do: acc
  defp suma([h1 | t1], [h2 | t2], acc), do: suma(t1, t2, acc ++ [h1 + h2])

  defp sort(tupple_list) do
    Enum.sort_by(tupple_list, fn {_k, v} -> List.last(v) end, :desc)
  end

  defp format(tupple_list) do
    tupple_list
    |> List.insert_at(0, {"Team", ~w[MP  W  D  L  P]})
    |> Enum.map(&format_rows(&1))
    |> Enum.join("\n")
  end

  defp format_rows({k, v}) do
    String.pad_trailing(k, 31, " ") <>
      "| " <>
      (v
       |> Enum.map(&String.pad_leading("#{&1}", 2, " "))
       |> Enum.join(" | "))
  end
end
