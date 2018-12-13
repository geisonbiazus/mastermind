defmodule MasterMind.CodeMaker do
  def score(code, guess) do
    p = position_matches(code, guess)
    v = value_matches(code, guess)
    o = over_count(code, guess)

    [p, v - p - o]
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

  defp over_count(code, guess) do
    code
    |> Stream.map(&(count_of(guess, &1) - count_of(code, &1)))
    |> Stream.filter(&(&1 >= 0))
    |> Enum.sum()
  end

  defp count_of(values, value) do
    Enum.count(values, &(&1 == value))
  end

  defp count_true(bool_list) do
    bool_list
    |> Stream.filter(& &1)
    |> Enum.count()
  end
end
