defmodule Acronym do
  @valid_characters ~r/([a-zA-Z\']+)/
  @acronym ~r/^([A-Z])[A-Z]*$/
  @first_c ~r{^\w}
  @lowcase ~r{[^A-Z]}

  def abbreviate(string) do
    string
    |> tokenize_valid_characters()
    |> process_terms
  end

  defp tokenize_valid_characters(string) do
    string
    |> (&Regex.scan(@valid_characters, &1)).()
    |> Enum.map(&List.first/1)
  end

  defp process_terms(list_of_terms) do
    list_of_terms
    |> Enum.map(&extract_letter/1)
    |> Enum.join()
  end

  defp extract_letter(term) do
    term
    |> abbreviate_acronyms
    |> upcase_first_letter
    |> remove_all_downcase
  end

  defp abbreviate_acronyms(w), do: String.replace(w, @acronym, "\\1")
  defp upcase_first_letter(w), do: String.replace(w, @first_c, &String.upcase/1)
  defp remove_all_downcase(w), do: String.replace(w, @lowcase, "")
end
