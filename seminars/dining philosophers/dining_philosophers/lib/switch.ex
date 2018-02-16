defmodule Switch do
  def start() do
    spawn_link(fn -> off() end)
  end

  def off() do
    receive do
      :push -> IO.puts "OFF -> ON"
      on()
    end
  end

  def on do
    receive do
      :push -> IO.puts "ON -> OFF"
      off()
    end
  end
end
