defmodule Palindromes do
  def generate(max, min \\ 1, acc \\ %{})
  def generate(max, min, acc) when min > max, do: acc
  def generate(max, min, acc) do
    min..max
    |> compute_products
    |> select_palindromes
    |> (&generate(max, min + 1, add_to(acc, &1))).()
  end

  def compute_products(from..to) do
    Enum.map((from..to), &({&1 * from, [from, &1]}))
  end

  def select_palindromes(listo) do
    listo
    |> Enum.filter(fn {x, _} ->
      s = Integer.to_string(x)
      s == String.reverse(s)
    end)
  end

  def add_to(map, []), do: map
  def add_to(map, [{prod, facts} | tail]) do
    map
    |> Map.update(prod, [facts], &([facts | &1]))
    |> add_to(tail)
  end
end
