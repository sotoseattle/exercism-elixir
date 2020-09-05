defmodule DiffieHellman do
  def generate_private_key(prime_p) do
    :rand.uniform(prime_p - 1)
  end

  def generate_public_key(prime_p, prime_g, private_key) do
    pow_mod(prime_g, private_key, prime_p)
  end

  def generate_shared_secret(prime_p, public_key_b, private_key_a) do
    pow_mod(public_key_b, private_key_a, prime_p)
  end

  defp pow_mod(a, b, c) do
    a |> :crypto.mod_pow(b, c) |> :binary.decode_unsigned()
  end

end
