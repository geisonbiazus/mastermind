defmodule MasterMind.AutoPlayTest do
  use ExUnit.Case

  import Mock

  alias MasterMind.{AutoPlay, CodeRandomizer}

  describe "play" do
    test "returns 1 if initial guess is correct" do
      with_mock(CodeRandomizer, random_code: fn -> [0, 0, 0, 0] end) do
        assert AutoPlay.play() == 1
      end
    end

    test "takes two tries if code is [0 0 0 1]" do
      with_mock(CodeRandomizer, random_code: fn -> [0, 0, 0, 1] end) do
        assert AutoPlay.play() == 2
      end
    end

    test "takes three tries if code is [0 0 1 0]" do
      with_mock(CodeRandomizer, random_code: fn -> [0, 0, 1, 0] end) do
        assert AutoPlay.play() == 3
      end
    end
  end
end
