defmodule Advent.Day2Test do
  use ExUnit.Case
  alias Advent.Day2

  test "part 1" do
    assert Day2.part_1("1,0,0,0,99") == "2,0,0,0,99"
    assert Day2.part_1("2,3,0,3,99") == "2,3,0,6,99"
    assert Day2.part_1("2,4,4,5,99,0") == "2,4,4,5,99,9801"
    assert Day2.part_1("1,1,1,4,99,5,6,0,99") == "30,1,1,4,2,5,6,0,99"
  end
end
