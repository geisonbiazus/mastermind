defmodule MasterMind.CodeBreaker do
  alias MasterMind.CodeMaker

  def break_code(nil, []) do
    [0, 0, 0, 0]
  end

  def break_code(last_guess, past_guesses) do
    next_guess(inc_guess(last_guess), past_guesses)
  end

  defp next_guess([0, 0, 0, 0], _past_guesses), do: :error

  defp next_guess(guess, past_guesses) do
    if Enum.all?(past_guesses, fn [past_guess, past_result] ->
         CodeMaker.score(guess, past_guess) == past_result
       end) do
      guess
    else
      next_guess(inc_guess(guess), past_guesses)
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
