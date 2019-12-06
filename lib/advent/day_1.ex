defmodule Advent.Day1 do
  @spec execute() :: integer
  def execute() do
    File.read!("inputs/day_1.txt")
    |> execute
  end

  @spec execute(binary | integer) :: integer
  def execute(input) when is_binary(input) do
    input
    |> String.split("\n")
    |> Enum.reduce(0, fn el, acc ->
      Integer.parse(el)
      |> case do
        :error -> acc
        {num, _} -> acc + execute(num)
      end
    end)
  end

  def execute(input) when is_integer(input) do
    floor(input / 3) - 2
  end
end
