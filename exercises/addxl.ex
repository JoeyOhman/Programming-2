defmodule Test do

  def add(x, l) do

    unless (contains(x,l)) do
      [x | l]
    else
      l
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
