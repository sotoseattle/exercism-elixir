defmodule Gigasecond do
  @gigasecond 1_000_000_000

  def from({{year, month, day}, {hours, minutes, seconds}}) do
    {:ok, date} = NaiveDateTime.new(year, month, day, hours, minutes, seconds, 0)

    date_time = NaiveDateTime.add(date, @gigasecond)
    d = NaiveDateTime.to_date(date_time)
    t = NaiveDateTime.to_time(date_time)

    {{d.year, d.month, d.day}, {t.hour, t.minute, t.second}}
  end
end
