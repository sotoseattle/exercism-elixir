defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """

  @dicto %{
    1 => "wink",
    10 => "double blink",
    100 => "close your eyes",
    1000 => "jump"}

  @spec commands(code :: integer) :: list(String.t())

  def commands(code) do
    code
    |> binafy_input
    |> check_if_reversible
    |> check(1_000)
    |> apply_reversible
  end

  def binafy_input code do
    code
    |> Integer.digits(2)
    |> Enum.join
    |> String.to_integer
  end

  def check_if_reversible(x) do
    %{ n: rem(x, 10_000),
       reverse: div(x, 10_000) == 1,
       sol: []}
  end

  def check(e, 0), do: e

  def check( %{n: n, reverse: _r, sol: sol } = e, m) when div(n, m) == 1 do
    check( %{ e | sol: [@dicto[m] | sol], n: rem(n, m) }, div(m, 10) )
  end

  def check(e, m), do: check( e, div(m, 10) )

  def apply_reversible( ,%{reverse: reverse, sol: sol} ) when reverse do
    Enum.reverse(sol)
  end

  def apply_reversible(e), do: e[:sol]

end

# IO.inspect SecretHandshake.commands(2)