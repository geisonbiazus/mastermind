defmodule MasterMind.CodeMaker do
  def score(code, guess) do
    Enum.zip(code, guess)
    |> Enum.map(fn {a, b} -> a == b && :pos end)
    |> Enum.reject(&(!&1))
  end
end
