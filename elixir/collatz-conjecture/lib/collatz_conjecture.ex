defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """

  def calc(input, acc \\ 0)

  def calc(n, _acc) when n <= 0 or not is_integer(n) do
    raise(FunctionClauseError)
  end

  def calc(1, acc), do: acc

  def calc(input, acc) when rem(input, 2) == 0 do
    calc(div(input, 2), acc + 1)
  end

  def calc(input, acc) do
    calc(3 * input + 1, acc + 1)
  end
end
