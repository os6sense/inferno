defmodule Chrysopoeia.Parser.ParseTree.Walker do
  @moduledoc
  """
    Methods for walking the parsetree
  """
  import IO, only: [puts: 1]

  @doc ~S"""
    Walk a parse tree of the syntax pt = {element, arguments, [<{pt}>...]]} 
    where pt can be a recuring child element or re-occur multiple times.

    t: pt, as described above.
    fns: A list of selector/transform functions to be applied during the
         walk. See Transform.transform/2 
         a single function in the function list is of the form:

            fn(tuple, accumulator)

          e.g. the default copy function is:
            fn(t = {e, a, c}, acc) -> t end]
  """
  def walk(t, fns \\ [fn(t, a) -> t end]) when is_tuple(t) do
    IO.puts "Public"
    _walk(t, fns)
  end

  @doc ~S""" 
    matches a text node. The first form matches an empty list of transform
    functions.
  """
  def _walk(text , fns) when is_binary(text) do
    puts "Text Node 2 (fns) #{inspect text} || #{String.strip(text)}"
    String.strip(text)
  end
    
  # matches a text node with children
  def _walk(t = { _, _, [c]}, fns) when is_binary(c) do
    puts "Text Node 3 (fns) #{inspect t}"
    Enum.reduce([[]] ++ fns, fn(fun, r_acc) -> fun.(t, r_acc) end)
  end

  @doc ~S"""
    Add the element and arguments to the accumulator, apply the walk function
    to the tuple elements within the list c

    e: element
    a: arguments
    c: children
  """
  def _walk(t = {e, a, c = [head | tail]}, fns) when is_list(c) do
    puts "List Walk (fns) #{inspect e}"
    {e, a, c} = Enum.reduce([[]] ++ fns, fn(fun, r_acc) -> fun.(t, r_acc) end)

    unless e == :deleted, 
      do: {e, a, Enum.map(c, fn(et) -> _walk(et, fns) end )}
  end

  @doc ~S"""
    Matches the tuple with no children (i.e an empty list) as the last element.
  """
  def _walk(t = {_, _, []}, fns) do
    puts "Empty Last Element (fns) #{inspect t}"
    Enum.reduce([[]] ++ fns, fn(fun, r_acc) -> fun.(t, r_acc) end)
  end
end
