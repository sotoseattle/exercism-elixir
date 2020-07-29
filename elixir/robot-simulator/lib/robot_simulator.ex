defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial dir and pos.

  Valid dirs are: `:north`, `:east`, `:south`, `:west`
  """
  @ok_dirs [:north, :west, :east, :south]
  @ok_movs ~r{[LRA]}

  # defstruct [:dir, :pos]

  def create(), do: %{dir: :north, pos: {0, 0}}

  def create(nil, nil), do: create()

  def create(dir, _pos) when dir not in @ok_dirs, do: {:error, "invalid direction"}

  def create(dir, {a, b}) when is_integer(a) and is_integer(b) do
    %{dir: dir, pos: {a, b}}
  end

  def create(_, _), do: {:error, "invalid position"}

  def simulate(robot, instructions) do
    cond do
      {:error} == robot ->
        robot

      String.replace(instructions, @ok_movs, "") != "" ->
        {:error, "invalid instruction"}

      true ->
        instructions
        |> String.graphemes()
        |> Enum.reduce(robot, fn action, robot -> move(action, robot) end)
    end
  end

  defp move("R", %{dir: :north} = robot), do: %{robot | dir: :east}
  defp move("R", %{dir: :east} = robot), do: %{robot | dir: :south}
  defp move("R", %{dir: :south} = robot), do: %{robot | dir: :west}
  defp move("R", %{dir: :west} = robot), do: %{robot | dir: :north}

  defp move("L", %{dir: :north} = robot), do: %{robot | dir: :west}
  defp move("L", %{dir: :west} = robot), do: %{robot | dir: :south}
  defp move("L", %{dir: :south} = robot), do: %{robot | dir: :east}
  defp move("L", %{dir: :east} = robot), do: %{robot | dir: :north}

  defp move("A", %{dir: :north, pos: {a, b}} = robot), do: %{robot | pos: {a, b + 1}}
  defp move("A", %{dir: :west, pos: {a, b}} = robot), do: %{robot | pos: {a - 1, b}}
  defp move("A", %{dir: :south, pos: {a, b}} = robot), do: %{robot | pos: {a, b - 1}}
  defp move("A", %{dir: :east, pos: {a, b}} = robot), do: %{robot | pos: {a + 1, b}}

  def direction(robot), do: robot.dir

  def position(robot), do: robot.pos
end
