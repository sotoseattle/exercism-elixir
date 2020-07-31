defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """

  def of_rna(rna) do
    rna
    |> break_into_codons
    |> translate_to_proteins
  end

  defp break_into_codons(rna) do
    rna
    |> String.graphemes()
    |> Enum.chunk_every(3)
    |> Enum.map(&Enum.join(&1))
  end

  defp translate_to_proteins(list_of_codons) do
    list_of_codons
    |> Enum.map(&of_codon/1)
    |> format([])
  end

  defp format([], acc), do: {:ok, acc}
  defp format([{:ok, "STOP"} | _], acc), do: {:ok, acc}
  defp format([{:error, _} | _], _), do: {:error, "invalid RNA"}
  defp format([{:ok, protein} | t], acc), do: format(t, acc ++ [protein])

  @doc """
  Given a codon, return the corresponding protein
  """

  def of_codon(codon), do: protein_of(codon)

  defp protein_of("UGU"), do: {:ok, "Cysteine"}
  defp protein_of("UGC"), do: {:ok, "Cysteine"}
  defp protein_of("UUA"), do: {:ok, "Leucine"}
  defp protein_of("UUG"), do: {:ok, "Leucine"}
  defp protein_of("AUG"), do: {:ok, "Methionine"}
  defp protein_of("UUU"), do: {:ok, "Phenylalanine"}
  defp protein_of("UUC"), do: {:ok, "Phenylalanine"}
  defp protein_of("UCU"), do: {:ok, "Serine"}
  defp protein_of("UCC"), do: {:ok, "Serine"}
  defp protein_of("UCA"), do: {:ok, "Serine"}
  defp protein_of("UCG"), do: {:ok, "Serine"}
  defp protein_of("UGG"), do: {:ok, "Tryptophan"}
  defp protein_of("UAU"), do: {:ok, "Tyrosine"}
  defp protein_of("UAC"), do: {:ok, "Tyrosine"}
  defp protein_of("UAA"), do: {:ok, "STOP"}
  defp protein_of("UAG"), do: {:ok, "STOP"}
  defp protein_of("UGA"), do: {:ok, "STOP"}
  defp protein_of(_), do: {:error, "invalid codon"}
end
