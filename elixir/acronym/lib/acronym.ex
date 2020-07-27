defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  @acronym ~r/^([A-Z])[A-Z]*$/
  @first ~r{^\w}
  @lowcase ~r{[^A-Z]}

  def abbreviate(string) do
    string
    |> tokenize
    |> Enum.map(&extract_acronym/1)
    |> Enum.join()
  end

  defp tokenize(string) do
    Regex.scan(~r/([a-zA-Z\']+)/, string)
    |> Enum.map(&List.first/1)
  end

  defp extract_acronym(word) do
    word
    |> abbr_acronym
    |> cap_first_letter
    |> remove_downcase
  end

  defp abbr_acronym(w), do: String.replace(w, @acronym, "\\1")

  defp cap_first_letter(w), do: String.replace(w, @first, &String.upcase/1)

  defp remove_downcase(w), do: String.replace(w, @lowcase, "")
end
