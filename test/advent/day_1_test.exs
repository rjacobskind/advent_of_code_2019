defmodule Advent.Day1Test do
  use ExUnit.Case

  alias Advent.Day1

  describe "day 1" do
    test("part 1") do
      assert Day1.part_1(12) == 2
      assert Day1.part_1(14) == 2
      assert Day1.part_1(1969) == 654
      assert Day1.part_1(100_756) == 33583
    end

    test("part 2") do
      assert Day1.part_2(12) == 2
      assert Day1.part_2(1969) == 966
      assert Day1.part_2(100_756) == 50346
    end
  end
end
