defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  def nth(count, x \\ 2, primes \\ [])

  def nth(count, _, primes) when length(primes) == count, do: hd(primes)

  def nth(count, x, primes) do
    primes = (is_prime?(x, primes) && [x | primes]) || primes

    nth(count, x + 1, primes)
  end

  def is_prime?(n, previous_primes) do
    Enum.all?(previous_primes, &(rem(n, &1) != 0))
  end
end
