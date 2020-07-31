defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    filter(list, [], fun, true)
  end

  def filter([], acc, _fun, _keep), do: Enum.reverse(acc)

  def filter([h | t], acc, fun, keep) do
    if fun.(h) == keep do
      filter(t, [h | acc], fun, keep)
    else
      filter(t, acc, fun, keep)
    end
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    filter(list, [], fun, false)
  end
end
