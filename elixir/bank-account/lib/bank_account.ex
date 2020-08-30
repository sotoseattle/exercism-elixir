defmodule BankAccount do
  @opaque account :: pid

  def open_bank() do
    spawn(fn -> run(%{balance: 0, open?: true}) end)
  end

  defp run(map) do
    receive do
      {:balance, caller} ->
        respond(caller, map)
        run(map)
      {:update, caller, amount} ->
        new_map = %{map | balance: map.balance + amount}
        respond(caller, new_map)
        run(new_map)
      {:close} ->
        run(%{map | open?: false})
    end
  end

  defp respond(caller, %{open?: false}) do
    send(caller, {:error, :account_closed})
  end
  defp respond(caller, map) do
    send(caller, {:ok, map.balance})
  end

  def close_bank(account) do
    send(account, {:close})
  end

  def balance(account) do
    send(account, {:balance, self()})
    receive do
      {:ok, value} -> value
      {:error, msg} -> {:error, msg}
    end
  end

  def update(account, amount) do
    send(account, {:update, self(), amount})
    receive do
      {:ok, _value} -> nil
      {:error, msg} -> {:error, msg}
    end
  end
end
