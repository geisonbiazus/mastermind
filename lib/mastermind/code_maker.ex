defmodule MasterMind.CodeMaker do
  def score(code, guess) do
    [
      position_matches(code, guess)
    ]
  end

  defp position_matches(code, guess) do
    Stream.zip(code, guess)
    |> Stream.map(fn {a, b} -> a == b end)
    |> Stream.filter(& &1)
    |> Enum.count()
  end
end
