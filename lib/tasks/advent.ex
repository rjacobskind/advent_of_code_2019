defmodule Mix.Tasks.Advent do
  use Mix.Task

  @impl Mix.Task
  def run([day, part]) do
    mod = module(day)
    part = to_part_atom(part)

    mod.execute(part)
    |> Integer.to_string()
    |> Mix.shell().info()
  end

  defp module("1"), do: Advent.Day1

  defp to_part_atom("1"), do: :part_1
  defp to_part_atom("2"), do: :part_2
end
