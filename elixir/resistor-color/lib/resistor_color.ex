defmodule ResistorColor do

  def code(colorin) do
    Enum.find_index(colors(), &(&1 == colorin))
  end

  def colors do
    ~w[black brown red orange yellow green blue violet grey white]
  end
end
