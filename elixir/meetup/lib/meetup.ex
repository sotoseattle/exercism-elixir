defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday :: :monday | :tuesday | :wednesday | :thursday | :friday | :saturday | :sunday
  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  def meetup(year, month, weekday, schedule) do
    weekday
    |> get_all_weekdays_of(year, month)
    |> match_to(schedule)
    |> (&datum(year, month, &1)).()
  end

  defp get_all_weekdays_of(weekday, year, month) do
    Enum.filter(
      1..days_in_month(year, month),
      &is_same_day?(datum(year, month, &1), weekday)
    )
  end

  defp days_in_month(year, month),
    do: datum(year, month, 1) |> Date.days_in_month()

  defp is_same_day?(t, weekday),
    do: Date.day_of_week(t) == weekday_number(weekday)

  defp datum(y, m, d) do
    {:ok, t} = Date.new(y, m, d)
    t
  end

  defp match_to(day_list, :first), do: List.first(day_list)
  defp match_to(day_list, :second), do: Enum.at(day_list, 1)
  defp match_to(day_list, :third), do: Enum.at(day_list, 2)
  defp match_to(day_list, :fourth), do: Enum.at(day_list, 3)
  defp match_to(day_list, :last), do: List.last(day_list)

  defp match_to(day_list, :teenth) do
    day_list
    |> Enum.filter(&(&1 > 9 and &1 < 20))
    |> List.last()
  end

  defp weekday_number(:monday), do: 1
  defp weekday_number(:tuesday), do: 2
  defp weekday_number(:wednesday), do: 3
  defp weekday_number(:thursday), do: 4
  defp weekday_number(:friday), do: 5
  defp weekday_number(:saturday), do: 6
  defp weekday_number(:sunday), do: 7
end
