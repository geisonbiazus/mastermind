defmodule MasterMind.AutoPlayTest do
  use ExUnit.Case

  alias MasterMind.{AutoPlay, CodeBreaker}

  describe "play" do
    test "returns 1 if initial guess is correct" do
      assert AutoPlay.play(&CodeBreaker.break_code_seq/2, fn -> [0, 0, 0, 0] end) == 1
    end

    test "takes two tries if code is [0 0 0 1]" do
      assert AutoPlay.play(&CodeBreaker.break_code_seq/2, fn -> [0, 0, 0, 1] end) == 2
    end

    test "takes three tries if code is [0 0 1 0]" do
      assert AutoPlay.play(&CodeBreaker.break_code_seq/2, fn -> [0, 0, 1, 0] end) == 3
    end
  end

  describe "analyze_strategies" do
    test "plays the game many times and returns statistical results for each strategy" do
      {:ok, agent} =
        Agent.start_link(fn ->
          [
            [0, 5, 0, 3],
            [0, 2, 2, 1],
            [3, 5, 1, 0],
            [1, 1, 1, 1],
            [0, 5, 0, 3],
            [0, 2, 2, 1],
            [3, 5, 1, 0],
            [1, 1, 1, 1],
            [0, 5, 0, 3],
            [0, 2, 2, 1],
            [3, 5, 1, 0],
            [1, 1, 1, 1]
          ]
        end)

      random_code = fn ->
        Agent.get_and_update(agent, fn list ->
          [head | tail] = list
          {head, tail}
        end)
      end

      assert AutoPlay.analyze_strategies(4, random_code) ==
               %{
                 _3x2: %{
                   hist: [2, 2],
                   max: 6,
                   mean: 5.5,
                   median: 6,
                   min: 5,
                   sigma: 0.5773502691896257
                 },
                 double_rainbow: %{
                   hist: [1, 2, 1],
                   max: 6,
                   mean: 5.0,
                   median: 5,
                   min: 4,
                   sigma: 0.816496580927726
                 },
                 seq: %{
                   hist: [1, 1, 2],
                   max: 6,
                   mean: 4.75,
                   median: 6,
                   min: 2,
                   sigma: 1.8929694486000912
                 }
               }
    end
  end
end
