defmodule MasterMind.AutoPlay do
  alias MasterMind.{CodeBreaker, CodeMaker, CodeRandomizer}

  def play do
    auto_play(CodeRandomizer.random_code(), 1, [], nil)
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
end

defmodule MasterMind.CodeRandomizer do
  alias MasterMind.CodeBreaker

  def random_code do
    CodeBreaker.number_to_guess(:rand.uniform(6 * 6 * 6 * 6 - 1))
  end
end
