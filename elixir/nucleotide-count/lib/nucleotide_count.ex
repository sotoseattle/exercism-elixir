defmodule NucleotideCount do
  def histogram(strand) do
    [?A, ?C, ?G, ?T]
    |> Enum.map(fn nucleotide ->
      {nucleotide, count(strand, nucleotide)}
    end)
    |> Map.new()
  end

  def count(strand, nucleotide) do
    strand |> Enum.count(&(&1 == nucleotide))
  end
end
