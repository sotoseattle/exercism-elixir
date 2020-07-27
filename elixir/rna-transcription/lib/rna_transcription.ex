defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map( dna, &complement/1 )
  end
  
  def complement(?G), do: ?C
  def complement(?C), do: ?G
  def complement(?T), do: ?A
  def complement(?A), do: ?U

end