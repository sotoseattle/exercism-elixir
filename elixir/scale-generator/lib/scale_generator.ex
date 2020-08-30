defmodule ScaleGenerator do

  @chrom_scale ~w{A A# B C C# D D# E F F# G G#}
  @flaty_scale ~w(A Bb B C Db D Eb E F Gb G Ab)
  def step(scale, tonic, step) do
    build_scale(tonic, step, scale) |> Enum.at(1)
  end

  def chromatic_scale(tonic \\ "C") do
    pattern = String.duplicate("m", 12)
    build_scale(tonic, pattern, @chrom_scale)
  end

  def flat_chromatic_scale(tonic) do
    pattern = String.duplicate("m", 12)
    build_scale(tonic, pattern, @flaty_scale)
  end

  def find_chromatic_scale(tonic) when tonic in ~w{F Bb Eb Ab Db Gb d g c f bb eb} do
    flat_chromatic_scale(tonic)
  end
  def find_chromatic_scale(tonic) do
    chromatic_scale(tonic)
  end

  def scale(tonic, pattern) when tonic in ~w{F Bb Eb Ab Db Gb d g c f bb eb} do
    build_scale(tonic, pattern, @flaty_scale)
  end
  def scale(tonic, pattern) do
    build_scale(tonic, pattern, @chrom_scale)
  end

  defp reformat(tonic) when is_binary(tonic), do: reformat(String.graphemes(tonic))
  defp reformat([a]), do: String.upcase(a)
  defp reformat([a, b]), do: String.upcase(a) <> b

  defp create_stream(tonic, scale) do
    scale
    |> Stream.cycle()
    |> Stream.drop_while(&(&1 != tonic))
  end

  defp pattern(str_pattern) do
    str_pattern
    |> String.graphemes()
    |> Enum.map(&distance/1)
  end
  defp distance("m"), do: 1
  defp distance("M"), do: 2
  defp distance("A"), do: 3

  defp build_scale(tonic, pattern, scale) do
    tonic = reformat(tonic)
    pattern = pattern(pattern)

    tonic
    |> create_stream(scale)
    |> iterate_through_scale(pattern, [tonic])
  end

  defp iterate_through_scale(_stream, [], acc), do: acc
  defp iterate_through_scale(stream, [step | tail], acc) do
    stream = Stream.drop(stream, step)
    iterate_through_scale(stream, tail, acc ++ Enum.take(stream, 1))
  end
end
