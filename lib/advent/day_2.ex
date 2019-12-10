defmodule Advent.Day2 do
  @spec execute(:part_1 | :part_2) :: term()
  def execute(part) do
    File.read!("inputs/day_2.txt")
    |> execute(part)
  end

  def execute(input, :part_1) do
    input
    |> String.split(",")
    |> Enum.map(&String.to_integer(&1))
    |> List.replace_at(1, 12)
    |> List.replace_at(2, 2)
    |> process(0)
    |> Enum.at(0)
  end

  def part_1(input) do
    list =
      input
      |> String.split(",")
      |> Enum.map(&String.to_integer(&1))

    result = process(list, 0)

    Enum.join(result, ",")
  end

  defp process(list, pos) do
    list
    |> Enum.at(pos)
    |> case do
      99 -> list
      opcode -> compute(opcode, list, pos) |> process(pos + 4)
    end
  end

  defp compute(opcode, list, pos) do
    pos1 = Enum.at(list, pos + 1)
    pos2 = Enum.at(list, pos + 2)
    pos3 = Enum.at(list, pos + 3)

    res =
      case opcode do
        1 -> add(Enum.at(list, pos1), Enum.at(list, pos2))
        2 -> multiply(Enum.at(list, pos1), Enum.at(list, pos2))
      end

    List.replace_at(list, pos3, res)
  end

  defp add(a, b), do: a + b
  defp multiply(a, b), do: a * b
end
