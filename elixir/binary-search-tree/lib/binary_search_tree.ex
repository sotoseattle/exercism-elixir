defmodule BinarySearchTree do
  defstruct data: nil, left: nil, right: nil

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  def new(data),
    do: %BinarySearchTree{
      data: data,
      left: nil,
      right: nil
    }

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  def insert(nil, dato), do: new(dato)

  def insert(tree, dato) do
    if dato <= tree.data do
      %{tree | left: insert(tree.left, dato)}
    else
      %{tree | right: insert(tree.right, dato)}
    end
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  def in_order(tree, acc \\ [])
  def in_order(nil, acc), do: acc

  def in_order(tree, acc) do
    in_order(tree.left, acc) ++
      [tree.data] ++
      in_order(tree.right)
  end
end
