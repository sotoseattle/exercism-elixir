defmodule Year do
  @doc """
  Returns whether 'year' is a leap year.

  A leap year occurs:

  on every year that is evenly divisible by 4
    except every year that is evenly divisible by 100
      unless the year is also evenly divisible by 400
  """
  def leap_year?(year) do
    divisible_by_4_100_400(
      rem(year, 4) == 0,
      rem(year, 100) == 0,
      rem(year, 400) == 0
    )
  end

  defp divisible_by_4_100_400(true, true, false), do: false
  defp divisible_by_4_100_400(true, _, _), do: true
  defp divisible_by_4_100_400(_, _, _), do: false
end
