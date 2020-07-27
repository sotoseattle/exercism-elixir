defmodule DndCharacter do
  @abilities ~w[strength dexterity constitution intelligence wisdom charisma]a

  def modifier(score) do
    ((score - 10) / 2) |> Float.floor() |> Kernel.trunc()
  end

  def ability do
    roll_4d6()
    |> Enum.sort(:asc)
    |> Enum.drop(1)
    |> Enum.sum()
  end

  def character do
    @abilities
    |> Enum.reduce(%{}, &Map.put(&2, &1, ability()))
    |> compute_hp
  end

  defp roll_4d6 do
    for _roll <- 0..3, do: :rand.uniform(6)
  end

  defp compute_hp(pc) do
    hp = 10 + modifier(pc.constitution)
    Map.put(pc, :hitpoints, hp)
  end
end
