defmodule Garden do
  @base_names ~w[alice bob charlie david eve fred ginny harriet ileana joseph kincaid larry]a

  def info(garden_string, student_names \\ @base_names) do
    garden_string
    |> break_into_window_sills
    |> transpose_pots
    |> assign_to_students(student_names)
    |> Map.new
  end

  defp break_into_window_sills(garden_string) do
    garden_string
    |> String.split("\n")
    |> Enum.map(&process_each_row(&1))
  end

  defp process_each_row(window_sill) do
    window_sill
    |> convert_to_list_of_plants
    |> group_every_2_pots
  end

  defp convert_to_list_of_plants(window_sill) do
    window_sill
    |> String.graphemes
    |> Enum.map(&plant/1)
  end

  defp group_every_2_pots(pot_list), do: Enum.chunk_every(pot_list, 2)

  defp plant("R"), do: :radishes
  defp plant("C"), do: :clover
  defp plant("G"), do: :grass
  defp plant("V"), do: :violets

  defp transpose_pots(garden_list) do
    garden_list
    |> Enum.zip
    |> Enum.map(fn x ->
         x |> Tuple.to_list |> List.flatten() |> List.to_tuple()
       end)
  end

  defp assign_to_students(ordered_garden, student_names) do
    student_names
    |> unassigned_students(ordered_garden)
    |> complete_garden(ordered_garden)
    |> (&Enum.zip(Enum.sort(student_names), &1)).()
  end

  defp unassigned_students(student_list, garden_list) do
    length(student_list) - length(garden_list)
  end

  defp complete_garden(0, garden), do: garden
  defp complete_garden(z, garden) do
    complete_garden(z-1, garden ++ [{}])
  end
end
