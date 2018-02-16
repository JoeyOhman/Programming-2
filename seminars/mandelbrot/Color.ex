defmodule Color do

  def convert(depth, max) do
    f = depth / max
    a = f * 4
    x = trunc(a)
    y = trunc(255 * (a - x))

    blue(x ,y)

  end

  defp red(x, y) do
    case x do
      0 -> {:rgb, y, 0, 0}
      1 -> {:rgb, 255, y, 0}
      2 -> {:rgb, 255 - y, 255, 0}
      3 -> {:rgb, 0, 255, y}
      4 -> {:rgb, 0, 255 - y, 255}
    end
  end

  defp blue(x, y) do
    case x do
      0 -> {:rgb, 0, 0, y}
      1 -> {:rgb, 0, y, 255}
      2 -> {:rgb, 0, 255 - y, 255}
      3 -> {:rgb, 0, 255 - y, 255}
      4 -> {:rgb, 0, 255 - y, 255}
    end
  end

end
