defmodule Unique do

  def unique(l) do
    unique(l, [])
  end

  def unique([], lUnique) do lUnique end
  def unique(l, lUnique) do
    [head | tail] = l
    unless(contains(head, lUnique)) do
      IO.puts "Adding " <> Integer.to_string(head)
      unique(tail, lUnique ++ [head])
    else
      IO.puts "Not adding " <> Integer.to_string(head)
      unique(tail, lUnique)
    end
  end

  def contains(_, []) do false end
  def contains(x, l) do
    [head | tail] = l
    if(head == x) do
      true
    else
      contains(x, tail)
    end
  end

end
