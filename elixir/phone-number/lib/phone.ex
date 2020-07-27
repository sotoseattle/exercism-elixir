defmodule Phone do
  def number(raw) do
    raw
    |> input_ok?
    |> exract_digits
    |> length_ok?
    |> country_ok?
    |> area_ok?
    |> exchange_ok?
    |> format
  end

  defp input_ok?(raw) do
    if raw =~ ~r/[a-zA-Z]/, do: false, else: raw
  end

  defp exract_digits(false), do: false

  defp exract_digits(raw) do
    Regex.scan(~r/\d/, raw) |> List.flatten() |> Enum.join()
  end

  def length_ok?(false), do: false

  def length_ok?(phone) do
    case String.length(phone) do
      11 -> phone
      10 -> "1" <> phone
      _ -> false
    end
  end

  defp country_ok?(false), do: false

  defp country_ok?(phone) do
    if String.first(phone) != "1" do
      false
    else
      String.slice(phone, 1, 10)
    end
  end

  defp area_ok?(false), do: false

  defp area_ok?(phone) do
    if String.at(phone, 0) in ~w{0 1}, do: false, else: phone
  end

  defp exchange_ok?(false), do: false

  defp exchange_ok?(phone) do
    if String.at(phone, 3) in ~w{0 1}, do: false, else: phone
  end

  defp format(false), do: "0000000000"
  defp format(phone), do: phone

  def area_code(raw) do
    raw |> number() |> String.slice(0, 3)
  end

  def pretty(raw) do
    t = number(raw)

    "(#{String.slice(t, 0, 3)}) " <>
      String.slice(t, 3, 3) <>
      "-" <> String.slice(t, 6, 4)
  end
end
