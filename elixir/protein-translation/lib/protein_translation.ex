defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @dicto %{ "UGU" => "Cysteine",
             "UGC" => "Cysteine",
             "UUA" => "Leucine",
             "UUG" => "Leucine",
             "AUG" => "Methionine",
             "UUU" => "Phenylalanine",
             "UUC" => "Phenylalanine",
             "UCU" => "Serine",
             "UCC" => "Serine",
             "UCA" => "Serine",
             "UCG" => "Serine",
             "UGG" => "Tryptophan",
             "UAU" => "Tyrosine",
             "UAC" => "Tyrosine",
             "UAA" => "STOP",
             "UAG" => "STOP",
             "UGA" => "STOP" }

  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    rna
    |> String.graphemes
    |> Enum.chunk_every(3)
    |> Enum.map( &Enum.join(&1) )    
    |> Enum.map( &@dicto[&1] )
    |> output(%{status: nil, acc: []})
  end

  def output([], %{status: status, acc: acc}) when status == :error do
    {status, acc}
  end

  def output([], %{status: status, acc: acc}) do
    {status, Enum.reverse(acc)}
  end

  def output([h | t], %{ acc: acc}) do
    case h  do
      "STOP" -> output [], %{ acc: acc, status: :ok}
      nil    -> output [], %{acc: "invalid RNA", status: :error}
      _      -> output t,  %{acc: [h | acc], status: :ok}
    end
  end

  @doc """
  Given a codon, return the corresponding protein
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    if String.length(codon) != 3 do
      { :error, "invalid codon" }
    else
      { :ok, @dicto[codon] }
    end
  end

end
