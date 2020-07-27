defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(n) do
    [n, ""]
    |> noise([3, "Pling"]) 
    |> noise([5, "Plang"]) 
    |> noise([7, "Plong"]) 
    |> extract_noise
  end

  def noise([n, sol], [z, s]) when rem(n, z) == 0 do
    [n, sol <> s]
  end
  def noise([n, sol], _), do: [n, sol]

  def extract_noise([n, ""]),  do: Integer.to_string(n)
  def extract_noise([_n, sol]), do: sol 
  
end
