defmodule Advent.Day3 do
  @spec execute(:part_1 | :part_2) :: term()
  def execute(part) do
    File.read!("inputs/day_3.txt")
    |> String.split("\n")
    |> execute(part)
  end

  def execute([path_1, path_2], :part_1) do
    part_1(path_1, path_2)
  end

  def execute([path_1, path_2], :part_2) do
    part_2(path_1, path_2)
  end

  def part_1(path_1, path_2) do
    path_1 = String.split(path_1, ",")
    path_2 = String.split(path_2, ",")

    path_1_coords = generate_coords(path_1)
    path_2_coords = generate_coords(path_2)

    coords_in_common = compare_coords(path_1_coords, path_2_coords)
    find_smallest_distance(coords_in_common)
  end

  def part_2(path_1, path_2) do
    path_1 = String.split(path_1, ",")
    path_2 = String.split(path_2, ",")

    path_1_coords = generate_coords(path_1)
    path_2_coords = generate_coords(path_2)

    coords_in_common = compare_coords(path_1_coords, path_2_coords)
    find_smallest_steps(coords_in_common, path_1_coords, path_2_coords)
  end

  defp generate_coords(path) do
    Enum.reduce(path, [{0, 0}], fn instruction, acc ->
      direction = String.at(instruction, 0)
      steps = String.slice(instruction, 1..-1) |> String.to_integer()
      last_coord = List.last(acc)

      next_coords =
        case direction do
          "R" -> next_coords("x", steps, 1, last_coord)
          "L" -> next_coords("x", steps, -1, last_coord)
          "U" -> next_coords("y", steps, 1, last_coord)
          "D" -> next_coords("y", steps, -1, last_coord)
        end

      acc ++ next_coords
    end)
  end

  defp next_coords(axis_to_change, iterations, increment_val, {x, y} = _starting_coord) do
    next_coords = []

    if axis_to_change == "y" do
      for n <- 1..iterations do
        next_coords ++ {x, y + n * increment_val}
      end
    else
      for n <- 1..iterations do
        next_coords ++ {x + n * increment_val, y}
      end
    end
  end

  defp compare_coords(path_1_coords, path_2_coords) do
    # Grouping helps performance. We can compare the coordinates from path 1 to a subset of
    # path 2's coordinates.

    # REFACTOR OPPORTUNITY: We could improve performance further by grouping
    # path 1's coordinates and comparing 2 sub-groups to one another.

    path_2_groups = Enum.group_by(path_2_coords, fn {x, _y} -> x end)

    Enum.filter(path_1_coords, fn {x, _y} = coord ->
      path_2_group = Map.get(path_2_groups, x)

      if is_nil(path_2_group) or coord == {0, 0} do
        false
      else
        Enum.member?(path_2_group, coord)
      end
    end)
  end

  defp find_smallest_distance(coords_in_common) do
    {min_x, min_y} = Enum.min_by(coords_in_common, fn {x, y} -> abs(x) + abs(y) end)
    abs(min_x) + abs(min_y)
  end

  defp find_smallest_steps(coords_in_common, path_1_coords, path_2_coords) do
    Enum.reduce(coords_in_common, nil, fn c, acc ->
      steps = steps_sum(c, path_1_coords, path_2_coords)

      if is_nil(acc) or steps < acc do
        steps
      else
        acc
      end
    end)
  end

  defp steps_sum(c, path_1_coords, path_2_coords) do
    steps_1 = Enum.find_index(path_1_coords, fn coord -> coord == c end)
    steps_2 = Enum.find_index(path_2_coords, fn coord -> coord == c end)
    steps_1 + steps_2
  end
end
