defmodule MasterMind.CodeBreaker do
  alias MasterMind.CodeMaker

  def break_code(nil, []) do
    [0, 0, 0, 0]
  end

  def break_code(last_guess, past_guesses) do
    loop_code(inc_guess(last_guess), hd(past_guesses))
  end

  defp loop_code(guess, [last_guess, last_result] = last_guess_result) do
    if CodeMaker.score(guess, last_guess) == last_result do
      guess
    else
      loop_code(inc_guess(guess), last_guess_result)
    end
  end

  def inc_guess(guess) do
    guess
    |> guess_to_number
    |> inc
    |> number_to_guess
  end

  def guess_to_number(guess) do
    guess
    |> Enum.reduce(&(6 * &2 + &1))
  end

  def number_to_guess(n) do
    [
      rem(div(n, 6 * 6 * 6), 6),
      rem(div(n, 6 * 6), 6),
      rem(div(n, 6), 6),
      rem(n, 6)
    ]
  end

  defp inc(n) do
    n + 1
  end
end
