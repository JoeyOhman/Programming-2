defmodule Remove do

  def remove(x, []) do [] end
  def remove(x, l) do
    [head | tail] = l
    if(head == x) do
      remove(x, tail)
    else
      [head | remove(x, tail)]
    end
  end
  
end
