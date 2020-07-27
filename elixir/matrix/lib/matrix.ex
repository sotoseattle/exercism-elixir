defmodule Matrix do
  defstruct matrix: nil

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  def from_string(input) do
    m = %Matrix{}

    input
    |> String.replace("\n", " ")
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(3)
    |> (&%Matrix{m | matrix: &1}).()
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  def to_string(matrix) do
    matrix.matrix
    |> Enum.map(&Enum.join(&1, " "))
    |> Enum.join("\n")
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  def rows(matrix) do
    matrix.matrix
  end

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  def row(matrix, index) do
    Enum.at(matrix.matrix, index)
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  def columns(matrix) do
    Enum.map(0..2, &column(matrix, &1))
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  def column(matrix, index) do
    Enum.map(matrix.matrix, &Enum.at(&1, index))
  end
end
