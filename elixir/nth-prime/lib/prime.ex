defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  def nth(count, x \\ 2, primes \\ [])

  def nth(count, _z, primes) when length(primes) == count, do: hd(primes)

  def nth(count, x, primes) do
    primes = if is_prime?(x, primes), do: [x | primes], else: primes

    nth(count, x + 1, primes)
  end

  def is_prime?(n, previous_primes) do
    Enum.all?(previous_primes, fn x -> rem(n, x) != 0 end)
  end
end
