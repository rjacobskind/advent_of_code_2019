defmodule Advent.Day1Test do
  use ExUnit.Case

  alias Advent.Day1

  test("Day 1") do
    assert Day1.execute(12) == 2
    assert Day1.execute(14) == 2
    assert Day1.execute(1969) == 654
    assert Day1.execute(100_756) == 33583
  end
end
