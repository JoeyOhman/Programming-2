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

  def getTimeMillis() do
    :os.system_time(:milli_seconds)
  end

  def my_test(noChars) do
    msg = read("kallocain.txt", noChars)
    startTime = getTimeMillis()
    freq = freq(msg)
    freqTime = getTimeMillis() - startTime
    startTime = getTimeMillis()
    tree = tree(freq)
    treeTime = getTimeMillis() - startTime
    startTime = getTimeMillis()
    table = encode_table(tree)
    tableTime = getTimeMillis() - startTime
    startTime = getTimeMillis()
    code = encode(msg, table)
    encodeTime = getTimeMillis() - startTime
    startTime = getTimeMillis()
    decode(code, table)
    decodeTime = getTimeMillis() - startTime
    IO.inspect "Freq time: " <> to_string(freqTime)
    IO.inspect "Tree time: " <> to_string(treeTime)
    IO.inspect "Table time: " <> to_string(tableTime)
    IO.inspect "Encode time: " <> to_string(encodeTime)
    IO.inspect "Decode time: " <> to_string(decodeTime)
    "Sum time: " <> to_string(freqTime + treeTime + tableTime + encodeTime + decodeTime)

  end

  def test2(msg) do
    freq = freq(msg)
    IO.inspect freq
    tree = tree(freq)
    IO.inspect tree
    table = encode_table(tree)
    IO.inspect(table)
    code = encode(msg, table)
    IO.inspect(code)
    decode(code, table)
  end

  # Complexity: O(uniqueChars * msgSize + uniqueChars * log(uniqueChars))
  def freq(msg) do
    Enum.sort(freq(msg, []), fn ({_, f1}, {_, f2}) -> f1 <= f2 end)
  end
  def freq([], freqList) do freqList end
  def freq([char | rest], freqList) do
      freq(rest, update(freqList, char))
  end

  # Complexity: O(uniqueChars)
  def update([], char) do [{char, 1}] end
  def update([{char, f} | rest], char) do
    [{char, f+1} | rest]
  end
  def update([tuple | rest], char) do
    [tuple | update(rest, char)]
  end

  # Complexity: O(log(uniqueChars) * uniqueChars)
  def tree([{tree, _}]) do tree end
  def tree([{c1, f1}, {c2, f2} | rest]) do
    tree(insert({{c1, c2}, f1 + f2}, rest))
  end

  # Complexity: O(uniqueChars)
  def insert({c, f}, []) do [{c, f}] end
  def insert({c, f}, [{ch, fh} | t]) when f <= fh do
      [{c, f}, {ch, fh} | t]
  end
  def insert({c, f}, [h | t]) do
    [h | insert({c, f}, t)]
  end

  # Complexity O(treeSize)
  def encode_table(tree) do
    tree_to_table(tree, [])
  end

  def tree_to_table({}, _) do [] end
  #def tree_to_table({left, right}, path, acc) do
    #tree_to_table(left, path ++ [0], acc) ++ tree_to_table(right, path ++ [1], acc) ++ acc
  #end
  def tree_to_table({left, right}, path) do
    tree_to_table(left, path ++ [0]) ++ tree_to_table(right, path ++ [1])
  end
  def tree_to_table(char, path) do
    [{char, path}]
  end

  def decode_table(tree) do
    # To implement...
  end

  # Complexity: O(tableSize * msgSize)
  def encode([], _) do [] end
  def encode([char | rest], table) do
    encode_char(char, table) ++ encode(rest, table)
  end

  # Complexity: O(tableSize)
  def encode_char(char, [{char, path} | _]) do
    path
  end
  def encode_char(char, [{_, _} | rest]) do
    encode_char(char, rest)
  end

  # Complexity: O(treeSize * sequenceLength)
  def decode([], _) do [] end
  def decode(seq, table) do
    {char, rest} = decode_char(seq, 1, table)
    [char | decode(rest, table)]
  end

  # Complexity: O(treeSize)
  def decode_char(seq, n, table) do
    {code, rest} = Enum.split(seq, n)

    case List.keyfind(table, code, 1) do
      {char, _} -> {char, rest}
      nil -> decode_char(seq, n+1, table)
    end
  end

  def read(file, n) do
    {:ok, file} = File.open(file, [:read])
    binary = IO.read(file, n)
    File.close(file)
    case :unicode.characters_to_list(binary, :utf8) do
      {:incomplete, list, _} -> list;
      list -> list
    end
  end

end
