defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  def count(l, acc \\ 0)
  def count([], acc), do: acc
  def count([_ | t], acc), do: count(t, acc + 1)

  def reverse(l, acc \\ [])
  def reverse([], acc), do: acc
  def reverse([h | t], acc), do: reverse(t, [h | acc])

  def map(l, f, acc \\ [])
  def map([], _f, acc), do: Enum.reverse(acc)
  def map([h | t], f, acc), do: map(t, f, [f.(h) | acc])

  def filter(l, f, acc \\ [])
  def filter([], _f, acc), do: Enum.reverse(acc)

  def filter([h | t], f, acc) do
    filter(t, f, if(f.(h), do: [h | acc], else: acc))
  end

  def reduce(l, acc, f)
  def reduce([], acc, _f), do: acc
  def reduce([h | t], acc, f), do: reduce(t, f.(h, acc), f)

  def append(a, b), do: append_private(Enum.reverse(a), b)

  def concat(ll, acc \\ [])
  def concat([], acc), do: Enum.reverse(acc)

  def concat([h | t], acc) do
    if is_list(h) do
      concat(t, append_private(concat(h), acc))
    else
      concat(t, [h | acc])
    end
  end

  defp append_private([], b), do: b
  defp append_private([h | t], b), do: append_private(t, [h | b])
end
