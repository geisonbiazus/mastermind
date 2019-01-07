defmodule MasterMind.AutoPlay do
  alias MasterMind.{CodeBreaker, CodeMaker}

  def analyze_strategies(n, random_code_fn) do
    %{
      seq: analyze_strategy(&CodeBreaker.break_code_seq/2, n, random_code_fn),
      _3x2: analyze_strategy(&CodeBreaker.break_code_3x2/2, n, random_code_fn),
      double_rainbow:
        analyze_strategy(&CodeBreaker.break_code_double_rainbow/2, n, random_code_fn)
    }
  end

  defp analyze_strategy(strategy, n, random_code_fn) do
    scores = Enum.sort(Enum.map(1..n, fn _ -> play(strategy, random_code_fn) end))

    %{
      mean: mean(scores),
      sigma: sigma(scores),
      min: hd(scores),
      max: List.last(scores),
      median: median(scores),
      hist: hist(scores)
    }
  end

  def play(strategy), do: play(strategy, &random_code/0)

  def play(strategy, random_code_fn) do
    auto_play(strategy, random_code_fn.(), 1, [], nil)
  end

  defp auto_play(strategy, code, tries, past_scores, last_guess) do
    guess = strategy.(last_guess, past_scores)
    score = CodeMaker.score(code, guess)

    if score == [4, 0] do
      tries
    else
      auto_play(strategy, code, tries + 1, [[guess, score] | past_scores], guess)
    end
  end

  defp random_code do
    CodeBreaker.number_to_guess(:rand.uniform(6 * 6 * 6 * 6 - 1))
  end

  defp mean(x) do
    Enum.sum(x) / Enum.count(x)
  end

  defp sigma(x) do
    mn = mean(x)

    v = Enum.sum(Stream.map(x, &:math.pow(&1 - mn, 2)))
    :math.sqrt(v / (Enum.count(x) - 1))
  end

  defp median(x) do
    Enum.at(x, div(Enum.count(x), 2))
  end

  defp hist(x) do
    Enum.map(Enum.chunk_by(x, & &1), &Enum.count/1)
  end
end
