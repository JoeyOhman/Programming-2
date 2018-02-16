defmodule Mandel do

  def mandelbrot(width, height, x, y, k, depth) do
    trans = fn(w, h) ->
      Cmplx.new(x + k * (w - 1), y - k * (h - 1))
    end

    rows(width, height, trans, depth, [])
  end

  defp rows(_, 0, _, _, rows), do: rows
  defp rows(w, h, tr, depth, rows) do
    row = row(w, h, tr, depth, [])
    rows(w, h - 1, tr, depth, [row | rows])
  end

  defp row(0, _, _, _, row), do: row
  defp row(w, h, tr, depth, row) do
    c = tr.(w, h)
    res = Brot.mandelbrot(c, depth)
    color = Color.convert(res, depth)
    row(w - 1, h, tr, depth, [color | row])
  end

  def demo() do
    #small(-2.6, 1.2, 1.2)
    small(-0.134, 0.99, -0.123)
  end

  def small(x0, y0, xn) do
    width = 8000#3840
    height = 4300#2160
    depth = 150
    k = (xn - x0) / width
    image = Mandel.mandelbrot(width, height, x0, y0, k, depth)
    PPM.write("small.ppm", image)
  end

end
