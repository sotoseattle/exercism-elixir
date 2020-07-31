defmodule ResistorColor do
  @moduledoc false

  @spec colors() :: list(String.t())
  def colors do
    ["black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"]
  end

  @spec code(String.t()) :: integer()
  def code(colorin) do
    Enum.find_index(colors, &(&1 == colorin))
  end
end
