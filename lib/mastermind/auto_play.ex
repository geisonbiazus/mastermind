defmodule MasterMind.AutoPlay do
  alias MasterMind.{CodeBreaker, CodeMaker}

  def play, do: play(&random_code/0)

  def play(random_code_fn) do
    auto_play(random_code_fn.(), 1, [], nil)
  end

  defp auto_play(code, tries, past_scores, last_guess) do
    guess = CodeBreaker.break_code(last_guess, past_scores)
    score = CodeMaker.score(code, guess)

    if score == [4, 0] do
      tries
    else
      auto_play(code, tries + 1, [[guess, score] | past_scores], guess)
    end
  end

  defp random_code do
    CodeBreaker.number_to_guess(:rand.uniform(6 * 6 * 6 * 6 - 1))
  end

  def expected_turns(n) do
    scores = Enum.sort(Enum.map(1..n, fn _ -> play() end))

    %{
      mean: mean(scores),
      sigma: sigma(scores),
      min: hd(scores),
      max: List.last(scores),
      median: median(scores),
      hist: hist(scores)
    }
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
    Enum.map(Enum.chunk_by(x, & &1), &Enum.sum/1)
  end
end
