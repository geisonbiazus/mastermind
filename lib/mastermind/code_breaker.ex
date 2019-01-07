defmodule MasterMind.CodeBreaker do
  alias MasterMind.CodeMaker

  def break_code_seq(nil, []) do
    [0, 0, 0, 0]
  end

  def break_code_seq(last_guess, past_guesses) do
    next_guess(inc_guess(last_guess), past_guesses)
  end

  def break_code_3x2(last_guess, past_guesses) do
    case length(past_guesses) do
      0 -> [0, 0, 1, 1]
      1 -> [2, 2, 3, 3]
      2 -> [4, 4, 5, 5]
      3 -> next_guess([0, 0, 0, 0], past_guesses)
      _ -> next_guess(last_guess, past_guesses)
    end
  end

  def break_code_double_rainbow(last_guess, past_guesses) do
    case length(past_guesses) do
      0 -> [0, 1, 2, 3]
      1 -> [2, 3, 4, 5]
      2 -> [4, 5, 0, 1]
      3 -> next_guess([0, 0, 0, 0], past_guesses)
      _ -> next_guess(last_guess, past_guesses)
    end
  end

  defp next_guess(:overflow, _past_guesses), do: :error

  defp next_guess(guess, past_guesses) do
    if guess_consistent_with_past_guesses(guess, past_guesses) do
      guess
    else
      next_guess(inc_guess(guess), past_guesses)
    end
  end

  defp guess_consistent_with_past_guesses(guess, past_guesses) do
    Enum.all?(past_guesses, fn [past_guess, past_result] ->
      CodeMaker.score(guess, past_guess) == past_result
    end)
  end

  def inc_guess(guess) do
    guess
    |> guess_to_number
    |> inc
    |> number_to_guess
    |> check_overflow
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

  defp check_overflow([0, 0, 0, 0]), do: :overflow
  defp check_overflow(guess), do: guess
end
