defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  def add(db, name, grade) do
    Map.update(db, grade, [name], &[name | &1])
  end

  def grade(db, grade) do
    db[grade] || []
  end

  def sort(db) do
    db
    |> Map.keys()
    |> Enum.sort(:asc)
    |> Enum.reduce(%{}, fn k, acc -> Map.put(acc, k, Enum.sort(db[k])) end)
    |> Enum.to_list()
  end
end
