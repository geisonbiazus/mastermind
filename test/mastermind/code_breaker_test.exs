defmodule MasterMind.CodeBreakerTest do
  use ExUnit.Case

  alias MasterMind.CodeBreaker

  test "initial guess" do
    assert CodeBreaker.break_code({}) == {0, 0, 0, 0}
  end
end
