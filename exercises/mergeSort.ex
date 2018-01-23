defmodule MergeSort do

  def msort([]) do [] end
  def msort([x]) do [x] end
  def msort(l) do
    {l1, l2} = msplit(l, [], [])
    merge(msort(l1), msort(l2))
  end

  def merge([], l2) do l2 end
  def merge(l1, []) do l1 end
  def merge([h1 | t1], [h2 | _] = l2) when h1 < h2 do
    [h1 | merge(t1, l2)]
  end
  def merge(l1, [h2 | t2]) do
    [h2 | merge(l1, t2)]
  end

  def msplit([], l1, l2) do {l1, l2} end
  def msplit([h | t], l1, l2) do
    msplit(t, [h | l2], l1)
  end

end
