defmodule InsertionSort do

  def insert(element, []) do [element] end
  def insert(element, [head | tail]) when element < head do
    [element, head | tail]
  end
  def insert(element, [head | tail]) do
    [head | insert(element, tail)]
  end


  def isort(list) do isort(list, []) end

  def isort([], sorted) do sorted end
  def isort([head | tail], sorted) do
    isort(tail, insert(head, sorted))
  end

  #def isort(list, sorted) do
  #  case list do
  #    [] -> sorted
  #    [h|t] -> isort(t, insert(h, sorted))
  #  end
  #end

end
