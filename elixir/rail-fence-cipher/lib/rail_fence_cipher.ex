defmodule RailFenceCipher do
  def encode(string, 1), do: string
  def encode(string, n_tracks) do
    n_tracks
    |> tokenize(string)
    |> compute_sequencing
    |> ready_virgin_tape(:enc)
    |> encode_tape
    |> format_output
  end

  def decode(string, 1), do: string
  def decode(string, n_tracks) do
    n_tracks
    |> tokenize(string)
    |> compute_sequencing
    |> ready_virgin_tape(:dec)
    |> decode_tape
    |> format_output
  end

  defp tokenize(tracks, string) do
    %{ input: String.graphemes(string),
       tape: nil,
       n_tracks: tracks,
       track_order: nil}
  end

  defp ready_virgin_tape(token, :enc) do
    %{token | tape: List.duplicate("", token.n_tracks)}
  end

  defp ready_virgin_tape(token, :dec) do
    %{token | tape: token.track_order}
  end

  defp compute_sequencing(token) do
    n = token.n_tracks
    order = [(0..n-1), (n-2..1)]
    |> Enum.map(&Enum.to_list/1)
    |> List.flatten
    |> Stream.cycle
    |> Enum.take(length(token.input))

    %{token | track_order: order}
  end

  defp encode_tape(token) do
    rec(token, Enum.zip(token.input, token.track_order))
  end

  defp rec(token, []), do: token
  defp rec(token, wip) do
    {{char, track}, mod_wip} = List.pop_at(wip, 0)

    mod_tape = update_in(token.tape, [Access.at(track)], &(&1<>char))

    rec(%{token | tape: mod_tape}, mod_wip)
  end

  defp format_output(token) do
    token.tape |> Enum.join
  end

  defp decode_tape(%{input: []} = token), do: token
  defp decode_tape(token) do
    {char,  mod_input} = List.pop_at(token.input, 0)

    decode_tape(%{
      input: mod_input,
      tape: dec(token.tape, char, 0)})
  end

  defp dec(char_list, char, number) do
    i = Enum.find_index(char_list, &(&1 == number))
    if i do
      List.replace_at(char_list, i, char)
    else
      dec(char_list, char, number+1)
    end
  end
end
