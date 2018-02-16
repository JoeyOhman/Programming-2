defmodule Philosopher do

@timeout 3000

  def sleep(t) do
    :timer.sleep(:rand.uniform(t))
  end

  def start(hunger, right, left, name, ctrl) do

    spawn_link(fn -> dream(hunger, right, left, name, ctrl) end)

  end

  def dream(hunger, right, left, name, ctrl) do
    sleep(1000)
    case hunger do
      0 ->
        IO.puts("#{name} DONE")
        send(ctrl, :done);
      _ ->
        IO.puts("#{name} Dreaming -> Waiting")
        wait(hunger, right, left, name, ctrl)
    end
  end

  def wait(hunger, right, left, name, ctrl) do
    case Chopstick.request(right, @timeout) do
      :no -> wait(hunger, right, left, name, ctrl)
      :ok -> IO.puts("#{name} received right chopstick!")
    end

    sleep(2000)

    case Chopstick.request(left, @timeout) do
      :no ->
        send(right, :return)
        wait(hunger, right, left, name, ctrl)
      :ok ->
        IO.puts("#{name} received left chopstick!")
        IO.puts("#{name} Waiting -> Eating")
        eat(hunger, right, left, name, ctrl)
    end

  end

  def eat(hunger, right, left, name, ctrl) do
      sleep(1000)
      send(right, :return)
      send(left, :return)

      IO.puts("#{name} Eating -> Dreaming")
      dream(hunger - 1, right, left, name, ctrl)
  end

end
