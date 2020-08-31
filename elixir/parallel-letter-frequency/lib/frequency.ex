defmodule Frequency do
  def frequency(texts, workers) do
    workers = enlist(workers)
    char_list = extract_chars(texts)

    char_list
    |> Enum.uniq()
    |> Enum.map(&process(&1, char_list, workers))
  end

  defp enlist(n, acc \\ [])
  defp enlist(0, acc), do: acc
  defp enlist(n, acc), do: enlist(n-1, [create_worker() | acc])
  defp create_worker, do: spawn(fn -> run(%{ready?: true}) end)

  defp extract_chars(texts) do
    texts
    |> Enum.join()
    |> String.replace(~r/[\s\d\_.,;:]/, "")
    |> String.downcase()
    |> String.to_charlist()
  end

  defp process(character, char_list, workers) do
    pid = get_idle(workers)

    send(pid, {:count, character, char_list, self()})
    receive do
      {:result, value} -> {List.to_string([character]), value}
    end
  end

  defp get_idle(workers) do
    workers
    |> Enum.find(fn pid ->
        send(pid, {:ready?, self()})
        receive do
          {:ready?, true} -> pid
          {:ready?, false} -> get_idle(workers)
        end
        end)
  end

  defp run(map) do
    receive do
      {:count, character, char_list, caller} ->
        map = %{map | ready?: false}
        v = Enum.count(char_list, fn x -> character == x end)
        send(caller, {:result, v})
        run(%{map | ready?: true})
      {:ready?, caller} ->
        send(caller, {:ready?, map.ready?})
        run(map)
    end
  end
end
