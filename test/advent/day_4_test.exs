defmodule Advent.Day4Test do
  use ExUnit.Case
  alias Advent.Day4

  test "part 1" do
    assert Day4.check_for_validity_part_1("111111") == true
    assert Day4.check_for_validity_part_1("223450") == false
    assert Day4.check_for_validity_part_1("123789") == false
  end

  test "part 2" do
    assert Day4.check_for_validity_part_2("112233") == true
    # assert Day4.check_for_validity_part_2("123444") == false
    # assert Day4.check_for_validity_part_2("111122") == true
  end
end
