defmodule RailFenceCipher do
  def encode(str, 1), do: str
  def encode(str, tracks) do
    str
    |> recorder(tracks)
    |> Enum.join()
  end

  defp recorder(string, tracks) do
    positions_to_record = needle(string, tracks)

    string
    |> String.graphemes
    |> Enum.zip(positions_to_record)
    |> record(virgin_record(tracks))
  end

  defp needle(string, n_tracks) do
    [(0..n_tracks-1), (n_tracks-2..1)]
    |> Enum.map(&Enum.to_list/1)
    |> List.flatten
    |> Stream.cycle
    |> Enum.take(String.length(string))
  end

  defp record([], list), do: list
  defp record([{char, row} | t], list) do
    list
    |> List.update_at(row, &(&1 <> char))
    |> (&record(t, &1)).()
  end

  defp virgin_record(n_tracks) do
    " "
    |> String.duplicate(n_tracks)
    |> String.graphemes()
    |> Enum.map(fn _ -> "" end)
  end

  def decode(string, 1), do: string
  def decode(string, n_tracks) do
    positions_to_record = needle(string, n_tracks)

    string
    |> break_into_tracks(n_tracks)
    |> reader(positions_to_record, "")
  end

  defp break_into_tracks(str, n) do
    str
    |> recorder(n)
    |> Enum.map(&String.length/1)
    |> slicer(str, [])
    |> Enum.map(&String.graphemes/1)
  end

  defp slicer([], _str, acc), do: Enum.reverse(acc)
  defp slicer([h | t], str, acc) do
    prefix = String.slice(str, h..-1)
    suffix = String.slice(str, 0..h-1)
    slicer(t, prefix, [suffix | acc])
  end

  defp reader(_recording, [], acc), do: acc
  defp reader(recording, needle_list, acc) do
    {track, mod_needle_list} = List.pop_at(needle_list, 0)
    {char, mod_recording} = read(track, recording)

    reader(
      mod_recording,
      mod_needle_list,
      acc <> char
    )
  end

  defp read(track, recording) do
    get_and_update_in(
      recording,
      [Access.at(track)],
      fn x -> List.pop_at(x, 0) end
      )
  end
end
