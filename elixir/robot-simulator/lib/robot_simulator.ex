defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial dir and pos.

  Valid dirs are: `:north`, `:east`, `:south`, `:west`
  """

  defstruct dir: :north, pos: {0, 0}

  defguardp valid_position(pos)
            when is_tuple(pos) and
                   tuple_size(pos) == 2 and
                   is_integer(elem(pos, 0)) and
                   is_integer(elem(pos, 1))

  defguardp valid_direction(dir) when dir in [:north, :west, :east, :south]

  def create(), do: %RobotSimulator{}

  def create(dir, _pos) when not valid_direction(dir),
    do: {:error, "invalid direction"}

  def create(_dir, pos) when not valid_position(pos),
    do: {:error, "invalid position"}

  def create(dir, pos),
    do: %RobotSimulator{dir: dir, pos: pos}

  def simulate({:error, _} = o_o), do: o_o

  def simulate(robot, instructions) do
    instructions
    |> String.graphemes()
    |> Enum.reduce(robot, fn action, robot -> move(action, robot) end)
  end

  defp move("R", %RobotSimulator{dir: :north} = robot), do: turn(robot, :east)
  defp move("R", %RobotSimulator{dir: :east} = robot), do: turn(robot, :south)
  defp move("R", %RobotSimulator{dir: :south} = robot), do: turn(robot, :west)
  defp move("R", %RobotSimulator{dir: :west} = robot), do: turn(robot, :north)

  defp move("L", %RobotSimulator{dir: :north} = robot), do: turn(robot, :west)
  defp move("L", %RobotSimulator{dir: :west} = robot), do: turn(robot, :south)
  defp move("L", %RobotSimulator{dir: :south} = robot), do: turn(robot, :east)
  defp move("L", %RobotSimulator{dir: :east} = robot), do: turn(robot, :north)

  defp move("A", %RobotSimulator{dir: :north} = robot), do: advance(robot, {0, 1})
  defp move("A", %RobotSimulator{dir: :west} = robot), do: advance(robot, {-1, 0})
  defp move("A", %RobotSimulator{dir: :south} = robot), do: advance(robot, {0, -1})
  defp move("A", %RobotSimulator{dir: :east} = robot), do: advance(robot, {+1, 0})

  defp move(_, _), do: {:error, "invalid instruction"}

  defp turn(robot, new_dir),
    do: %RobotSimulator{robot | dir: new_dir}

  defp advance(%RobotSimulator{pos: {x, y}} = robot, {add_x, add_y}) do
    %RobotSimulator{robot | pos: {x + add_x, y + add_y}}
  end

  def direction(robot), do: robot.dir

  def position(robot), do: robot.pos
end
