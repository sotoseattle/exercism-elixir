defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  def convert(n) do
    (pling(n) <> plang(n) <> plong(n))
    |> sound(n)
  end

  defp pling(n) when rem(n, 3) == 0, do: "Pling"
  defp pling(_), do: ""

  defp plang(n) when rem(n, 5) == 0, do: "Plang"
  defp plang(_), do: ""

  defp plong(n) when rem(n, 7) == 0, do: "Plong"
  defp plong(_), do: ""

  defp sound(noise, n) when noise == "", do: Integer.to_string(n)
  defp sound(noise, _), do: noise
end
