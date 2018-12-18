defmodule MasterMind.CodeBreakerTest do
  use ExUnit.Case

  alias MasterMind.CodeBreaker

  test "guess_to_number" do
    assert CodeBreaker.guess_to_number([0, 0, 0, 0]) == 0
    assert CodeBreaker.guess_to_number([0, 0, 0, 1]) == 1
    assert CodeBreaker.guess_to_number([0, 0, 1, 0]) == 6
    assert CodeBreaker.guess_to_number([0, 0, 1, 1]) == 7
    assert CodeBreaker.guess_to_number([0, 1, 1, 1]) == 43
    assert CodeBreaker.guess_to_number([1, 1, 1, 1]) == 259
    assert CodeBreaker.guess_to_number([5, 5, 5, 5]) == 6 * 6 * 6 * 6 - 1
  end

  test "number_to_guess" do
    assert CodeBreaker.number_to_guess(0) == [0, 0, 0, 0]
    assert CodeBreaker.number_to_guess(1) == [0, 0, 0, 1]
    assert CodeBreaker.number_to_guess(6) == [0, 0, 1, 0]
    assert CodeBreaker.number_to_guess(7) == [0, 0, 1, 1]
    assert CodeBreaker.number_to_guess(43) == [0, 1, 1, 1]
    assert CodeBreaker.number_to_guess(259) == [1, 1, 1, 1]
    assert CodeBreaker.number_to_guess(6 * 6 * 6 * 6 - 1) == [5, 5, 5, 5]
  end

  test "inc_guess" do
    assert CodeBreaker.inc_guess([0, 0, 0, 0]) == [0, 0, 0, 1]
    assert CodeBreaker.inc_guess([0, 0, 0, 5]) == [0, 0, 1, 0]
    assert CodeBreaker.inc_guess([0, 0, 5, 5]) == [0, 1, 0, 0]
    assert CodeBreaker.inc_guess([0, 5, 5, 4]) == [0, 5, 5, 5]
    assert CodeBreaker.inc_guess([0, 5, 5, 5]) == [1, 0, 0, 0]
    assert CodeBreaker.inc_guess([5, 5, 5, 5]) == [0, 0, 0, 0]
  end

  test "initial guess" do
    assert CodeBreaker.break_code(nil, []) == [0, 0, 0, 0]
  end

  test "first step for code [1, 2, 3, 4]" do
    last_guess = [0, 0, 0, 0]
    past_guesses = [[[0, 0, 0, 0], [0, 0]]]
    assert CodeBreaker.break_code(last_guess, past_guesses) == [1, 1, 1, 1]
  end

  test "first step for code [0, 0, 0, 1]" do
    last_guess = [0, 0, 0, 0]
    past_guesses = [[[0, 0, 0, 0], [3, 0]]]
    assert CodeBreaker.break_code(last_guess, past_guesses) == [0, 0, 0, 1]
  end

  test "second step for code [0, 0, 1, 0]" do
    last_guess = [0, 0, 0, 1]
    past_guesses = [[[0, 0, 0, 1], [2, 2]]]
    assert CodeBreaker.break_code(last_guess, past_guesses) == [0, 0, 1, 0]
  end

  test "two steps are required for [0, 0, 1, 0]" do
    last_guess = [0, 0, 0, 0]

    past_guesses = [
      [[0, 0, 0, 0], [3, 0]],
      [[0, 0, 0, 1], [2, 2]]
    ]

    assert CodeBreaker.break_code(last_guess, past_guesses) == [0, 0, 1, 0]
  end
end
