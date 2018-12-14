defmodule MasterMind.CodeBreaker do
  def break_code(past_guesses) do
    [0, 0, 0, 0]
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
end
