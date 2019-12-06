defmodule Advent.Day1 do
  @spec execute(:part_1 | :part_2) :: integer
  def execute(part) do
    File.read!("inputs/day_1.txt")
    |> execute(part)
  end

  @spec execute(binary() | integer()) :: integer
  def execute(input, part) when is_binary(input) do
    input
    |> String.split("\n")
    |> Enum.reduce(0, fn el, acc ->
      Integer.parse(el)
      |> case do
        :error -> acc
        {num, _} -> acc + execute(num, part)
      end
    end)
  end

  def execute(num, :part_1), do: part_1(num)
  def execute(num, :part_2), do: part_2(num)

  def part_1(input) when is_integer(input) do
    floor(input / 3) - 2
  end

  @spec part_2(integer()) :: integer

  def part_2(input) when is_integer(input) and input > 0 do
    sum = floor(input / 3) - 2
    sum = if sum < 0, do: 0, else: sum
    sum + part_2(sum)
  end

  def part_2(input) when is_integer(input), do: 0
end
