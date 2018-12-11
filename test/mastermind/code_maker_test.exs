defmodule MasterMind.CodeMakerTest do
  use ExUnit.Case

  alias MasterMind.CodeMaker

  test "score guess with no matches" do
    assert CodeMaker.score([0, 0, 0, 0], [1, 1, 1, 1]) == []
  end

  test "score guess with one :pos match" do
    assert CodeMaker.score([0, 0, 0, 0], [0, 1, 1, 1]) == [:pos]
  end

  test "score guess with two :pos match" do
    assert CodeMaker.score([0, 0, 0, 0], [0, 1, 1, 0]) == [:pos, :pos]
  end
end
