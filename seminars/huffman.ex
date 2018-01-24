defmodule Huffman do
  def sample do
    "the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off"
end
  def text, do: "this is something that we should encode"
  def test do
    sample = sample()
    tree = tree(sample)
    encode = encode_table(tree)
    decode = decode_table(tree)
    text = text()
    seq = encode(text, encode)
    decode(seq, decode)
  end

  def my_test(msg) do
    tree = tree(freq(msg))
    IO.inspect tree
    encode_table(tree)
  end

  def extractFreq ({c, f}) do f end

  def freq(msg) do
    Enum.sort(freq(msg, []), fn ({_, f1}, {_, f2}) -> f1 <= f2 end)
  end
  def freq([], freqList) do freqList end
  def freq([char | rest], freqList) do
      freq(rest, update(freqList, char))
  end

  # Returns element x if it is in the list, otherwise false
  def update([], char) do [{char, 1}] end
  def update([{char, f} | rest], char) do
    [{char, f+1} | rest]
  end
  def update([tuple | rest], char) do
    [tuple | update(rest, char)]
  end

  def tree([{tree, _}]) do tree end
  def tree([{c1, f1}, {c2, f2} | rest]) do
    tree(insert({{c1, c2}, f1 + f2}, rest))
  end

  def insert({c, f}, []) do [{c, f}] end
  def insert({c, f}, [{ch, fh} | t]) when f < fh do
      [{c, f}, {ch, fh} | t]
  end
  def insert({c, f}, [h | t]) do
    [h | insert({c, f}, t)]
  end

  def encode_table(tree) do
    tree_to_table(tree, [], [])
  end

  def tree_to_table({}, path, acc) do acc end
  def tree_to_table({left, right}, path, acc) do
    tree_to_table(left, path ++ [0], acc) ++ tree_to_table(right, path ++ [1], acc) ++ acc
  end
  def tree_to_table(char, path, _) do
    [{char, path}]
  end

  def decode_table(tree) do
    # To implement...
  end
  def encode(text, table) do
    # To implement...
  end
  def decode(seq, tree) do
    # To implement...
  end
end
