defmodule MasterMind.CodeBreakerTest do
  use ExUnit.Case

  alias MasterMind.CodeBreaker

  test "initial guess" do
    assert CodeBreaker.break_code({}) == [0, 0, 0, 0]
  end

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
end
