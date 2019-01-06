defmodule MasterMind.AutoPlayTest do
  use ExUnit.Case

  alias MasterMind.AutoPlay

  describe "play" do
    test "returns 1 if initial guess is correct" do
      assert AutoPlay.play(fn -> [0, 0, 0, 0] end) == 1
    end

    test "takes two tries if code is [0 0 0 1]" do
      assert AutoPlay.play(fn -> [0, 0, 0, 1] end) == 2
    end

    test "takes three tries if code is [0 0 1 0]" do
      assert AutoPlay.play(fn -> [0, 0, 1, 0] end) == 3
    end
  end

  describe "expected_turns" do
    test "plays the game many times and returns statistical results" do
      AutoPlay.expected_turns(3)
    end
  end
end
