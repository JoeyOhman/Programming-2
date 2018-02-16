defmodule Test do

  def start(), do: spawn(fn -> init() end)

  def init() do
    c1 = Chopstick.start()
    c2 = Chopstick.start()
    c3 = Chopstick.start()
    c4 = Chopstick.start()
    c5 = Chopstick.start()
    ctrl = self()
    hunger = 2
    Philosopher.start(hunger, c1, c2, "Arendt", ctrl)
    Philosopher.start(hunger, c2, c3, "Hypatia", ctrl)
    Philosopher.start(hunger, c3, c4, "Simone", ctrl)
    Philosopher.start(hunger, c4, c5, "Elisabeth", ctrl)
    Philosopher.start(hunger, c5, c1, "Ayn", ctrl)
    #wait(5, [c1, c2, c3, c4, c5])
  end

end
