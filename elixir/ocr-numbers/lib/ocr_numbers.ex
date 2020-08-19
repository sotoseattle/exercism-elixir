defmodule OcrNumbers do
  @doc """
  Given a 3 x 4 grid of pipes, underscores, and spaces, determine which number is represented, or
  whether it is garbled.
  """
  @spec convert([String.t()]) :: {:ok, String.t()} | {:error, charlist()}
  def convert(input) do
    input
    |> validate
    |> process
  end

  defp validate(input) do
    input
    |> create_token
    |> validate_line_count
    |> validate_column_count
  end

  defp create_token(raw_input), do: {:ok, raw_input}

  defp validate_line_count({:ok, input}) do
    groups_of_4?(rem(length(input), 4) == 0, input)
  end
  defp groups_of_4?(true, input), do: {:ok, input}
  defp groups_of_4?(false, _inp), do: {:error, 'invalid line count'}

  defp validate_column_count({:ok, input}) do
    x = Enum.all?(input, &(rem(String.length(&1), 3) == 0))
    groups_of_3_cols?(x, input)
  end
  defp validate_column_count(o_o), do: o_o
  defp groups_of_3_cols?(true, input), do: {:ok, input}
  defp groups_of_3_cols?(false, _inp), do: {:error, 'invalid column count'}

  defp process({:error, _} = o_o), do: o_o
  defp process({:ok, input}) do
    sol = input
    |> Enum.chunk_every(4)
    |> Enum.map(&break_up_digits/1)
    |> Enum.map(&ocr_digits/1)
    |> Enum.join(",")
    {:ok, sol}
  end

  defp break_up_digits(input) do
    collect_digits(chunkenized_rows(input), [])
  end

  defp collect_digits([[],[],[],[]], acc), do: Enum.reverse(acc)
  defp collect_digits(input, acc) do
    head_digit = input |> Enum.map(&hd/1) |> Enum.join
    rest = Enum.map(input, &tl/1)
    collect_digits(rest, [head_digit | acc])
  end

  defp chunkenized_rows(input) do
    Enum.map(input, &break_row_into_groups_of_3_chars/1)
  end

  defp break_row_into_groups_of_3_chars(row) do
    row
    |> String.graphemes
    |> Enum.chunk_every(3)
    |> Enum.map(&Enum.join/1)
  end

  defp ocr_digits(list_of_digits) do
    list_of_digits |> Enum.map(&to_number/1) |> Enum.join
  end

  defp to_number(" _ | ||_|   "), do: "0"
  defp to_number("     |  |   "), do: "1"
  defp to_number(" _  _||_    "), do: "2"
  defp to_number(" _  _| _|   "), do: "3"
  defp to_number("   |_|  |   "), do: "4"
  defp to_number(" _ |_  _|   "), do: "5"
  defp to_number(" _ |_ |_|   "), do: "6"
  defp to_number(" _   |  |   "), do: "7"
  defp to_number(" _ |_||_|   "), do: "8"
  defp to_number(" _ |_| _|   "), do: "9"
  defp to_number(_anything_else), do: "?"
end
