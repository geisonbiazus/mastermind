defmodule MasterMind.CodeMakerTest do
  use ExUnit.Case

  alias MasterMind.CodeMaker

  test "score guess with no matches" do
    assert CodeMaker.score([0, 0, 0, 0], [1, 1, 1, 1]) == [0]
  end

  test "score guess with one position matches" do
    assert CodeMaker.score([0, 0, 0, 0], [0, 1, 1, 1]) == [1]
  end

  test "score guess with two position matches" do
    assert CodeMaker.score([0, 0, 0, 0], [0, 1, 1, 0]) == [2]
    assert CodeMaker.score([0, 0, 0, 0], [1, 0, 1, 0]) == [2]
    assert CodeMaker.score([0, 0, 0, 0], [0, 1, 0, 1]) == [2]
  end

  test "score guess with many position matches" do
    assert CodeMaker.score([1, 1, 1, 1], [0, 1, 1, 1]) == [3]
    assert CodeMaker.score([0, 0, 0, 0], [0, 0, 0, 1]) == [3]
    assert CodeMaker.score([1, 2, 3, 4], [1, 2, 3, 4]) == [4]
  end
end
