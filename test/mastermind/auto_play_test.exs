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
      {:ok, agent} =
        Agent.start_link(fn ->
          [[0, 5, 0, 3], [0, 2, 2, 1], [3, 5, 1, 0], [1, 1, 1, 1]]
        end)

      random_code = fn ->
        Agent.get_and_update(agent, fn list ->
          [head | tail] = list
          {head, tail}
        end)
      end

      assert AutoPlay.expected_turns(4, random_code) ==
               %{
                 hist: [2, 5, 12],
                 max: 6,
                 mean: 4.75,
                 median: 6,
                 min: 2,
                 sigma: 1.8929694486000912
               }
    end
  end
end
