defmodule Env do

  def test() do
    env = new()
    env = add(:x, 1337, env)
    env = add(:y, 10, env)
    env = remove([:x], env)
    lookup(:y, env)
  end

  def new() do [] end

  def add(id, str, env) do
    [{id, str} | env]
  end

  def lookup(id, env) do
    List.keyfind(env, id, 0)
  end

  def remove([], env) do
    env
  end
  def remove([idH | idT], env) do
    newEnv = remove(idH, env)
    remove(idT, newEnv)
  end

  def remove(id, env) do
    List.keydelete(env, id, 0)
  end

end
