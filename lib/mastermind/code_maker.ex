defmodule MasterMind.CodeMaker do
  def score(code, guess) do
    p = position_matches(code, guess)
    v = value_matches(code, guess)

    [p, v - p]
  end

  defp position_matches(code, guess) do
    Stream.zip(code, guess)
    |> Stream.map(fn {a, b} -> a == b end)
    |> count_true
  end

  defp value_matches(code, guess) do
    guess
    |> Stream.map(&Enum.member?(code, &1))
    |> count_true
  end

  defp count_true(bool_list) do
    bool_list
    |> Stream.filter(& &1)
    |> Enum.count()
  end
end
