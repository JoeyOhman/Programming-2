defmodule Eager do

  def eval_expr({:atm, id}, _) do {:ok, id} end
  def eval_expr({:var, id}, env) do
    case Env.lookup(id, env) do
      nil -> :error
      {_, str} -> {:ok, str}
    end
  end

  def eval_expr({:cons, he, te}, env) do
    case eval_expr(he, env) do
      :error -> :error
      {:ok, strH} ->
        case eval_expr(te, env) do
          :error -> :error
          {:ok, strT} -> {:ok, {strH, strT}}
        end
    end
  end

  def eval_match(:ignore, _, env) do
    {:ok, env}
  end

  def eval_match({:atm, id}, id, env) do
    {:ok, env}
  end

  def eval_match({:var, id}, str, env) do
    case Env.lookup(id, env) do
      nil -> {:ok, Env.add(id, str, env)}
      {_, ^str} -> {:ok, env}
      {_, _} -> :fail
    end
  end

  def eval_match({:cons, hp, tp}, {:cons, {_, str1}, {_, str2}}, env) do
    case eval_match(hp, str1, env) do
      :fail -> :fail
      {:ok, newEnv} -> eval_match(tp, str2, newEnv)
    end
  end

  def eval_match(_, _, _) do
    :fail
  end

  def eval_seq([exp], env) do
    eval_expr(exp, env)
  end

  def eval_seq([{:match, lhs, rhs} | rest], env) do
    case eval_expr(lhs, env) do
      :error ->
        {:ok, newEnv} =
          case rhs do
            {:cons, _, _} -> eval_match(lhs, rhs, env)
            {_, str} -> eval_match(lhs, str, env)
          end
        eval_seq(rest, newEnv)

      {:ok, _} ->
        vars = extract_vars(lhs)
        newEnv = Env.remove(vars, env)
        case rhs do
          {:cons, _, _} ->
            case eval_match(lhs, rhs, newEnv) do
              :fail -> :error
              {:ok, newEnv} -> eval_seq(rest, newEnv)
            end
          {_, str} ->
            case eval_match(lhs, str, env) do
              :fail -> :error
              {:ok, newEnv} -> eval_seq(rest, newEnv)
            end
        end
    end
  end

  def extract_vars(pattern) do
    case pattern do
      {:match, {:cons, {:var, x}, {:var, y}}} -> [x, y]
      {:match, {:cons, {:var, x}, :ignore}} -> [x]
      {:match, {:cons, :ignore, {:var, x}}} -> [x]
      {:match, {:var, x}} -> [x]
    end
  end


end
