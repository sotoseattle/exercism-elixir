defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> ISBNVerifier.isbn?("3-598-21507-X")
      true

      iex> ISBNVerifier.isbn?("3-598-2K507-0")
      false

  """
  @valid_isbn ~r/^\d{9}[\dX]$/

  def isbn?(isbn) do
    isbn
    |> validator
    |> verifier
  end

  defp validator(isbn) do
    isbn = String.replace(isbn, "-", "")

    if Regex.match?(@valid_isbn, isbn) do
      isbn
      |> String.graphemes()
      |> Enum.map(&to_int/1)
    else
      false
    end
  end

  defp to_int("X"), do: 10
  defp to_int(n), do: String.to_integer(n)

  def verifier(false), do: false

  def verifier(listo) do
    listo
    |> Enum.zip(10..1)
    |> Enum.map(fn {x, y} -> x * y end)
    |> Enum.reduce(&Kernel.+/2)
    |> rem(11) == 0
  end
end
