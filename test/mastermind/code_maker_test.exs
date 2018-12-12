defmodule MasterMind.CodeMakerTest do
  use ExUnit.Case

  alias MasterMind.CodeMaker

  describe "scoring position matches" do
    test "score guess with no matches" do
      assert CodeMaker.score([0, 0, 0, 0], [1, 1, 1, 1]) == [0, 0]
    end

    test "score guess with one position matches" do
      assert CodeMaker.score([0, 0, 0, 0], [0, 1, 1, 1]) == [1, 0]
    end

    test "score guess with two position matches" do
      assert CodeMaker.score([0, 0, 0, 0], [0, 1, 1, 0]) == [2, 0]
      assert CodeMaker.score([0, 0, 0, 0], [1, 0, 1, 0]) == [2, 0]
      assert CodeMaker.score([0, 0, 0, 0], [0, 1, 0, 1]) == [2, 0]
    end

    test "score guess with many position matches" do
      assert CodeMaker.score([1, 1, 1, 1], [0, 1, 1, 1]) == [3, 0]
      assert CodeMaker.score([0, 0, 0, 0], [0, 0, 0, 1]) == [3, 0]
      assert CodeMaker.score([1, 2, 3, 4], [1, 2, 3, 4]) == [4, 0]
    end
  end

  describe "scoring value matches" do
    test "value matches" do
      assert CodeMaker.score([1, 2, 3, 4], [2, 0, 0, 0]) == [0, 1]
      assert CodeMaker.score([1, 2, 3, 4], [2, 3, 0, 0]) == [0, 2]
      assert CodeMaker.score([1, 2, 3, 4], [2, 4, 1, 0]) == [0, 3]
      assert CodeMaker.score([1, 2, 3, 4], [4, 3, 2, 1]) == [0, 4]
      assert CodeMaker.score([1, 2, 3, 4], [2, 3, 4, 1]) == [0, 4]
    end
  end

  test "guesses with some position and some value matches" do
    assert CodeMaker.score([1, 2, 3, 4], [1, 2, 4, 3]) == [2, 2]
  end
end
