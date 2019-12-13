defmodule Advent.Day4 do
  @spec execute(:part_1 | :part_2) :: term()
  def execute(part) do
    File.read!("inputs/day_4.txt")
    |> execute(part)
  end

  def execute(input, :part_1) do
    String.split(input, "-")
    |> Enum.map(fn x -> String.to_integer(x) end)
    |> part_1()

  end

  def execute(input, :part_2) do
    String.split(input, "-")
    |> Enum.map(fn x -> String.to_integer(x) end)
    |> part_2()
  end

  def part_1([lower_lim, upper_lim]) do
    Enum.reduce(lower_lim..upper_lim, 0, fn int, acc ->
      is_valid = check_for_validity_part_1(int)

      if (is_valid) do
        acc + 1
      else
        acc
      end
    end)
  end

  def part_2([lower_lim, upper_lim]) do
    Enum.reduce(lower_lim..upper_lim, 0, fn int, acc ->
      is_valid = check_for_validity_part_2(int)

      if (is_valid) do
        acc + 1
      else
        acc
      end
    end)
  end

  def check_for_validity_part_1(int) do
    digit_list = String.split("#{int}", "", trim: true)
    with true <- is_proper_length?(digit_list),
         true <- has_same_adjacent_digits?(digit_list),
         true <- increasing_digit_vals?(digit_list) do
          true
         else
          _ -> false
         end

  end

  def check_for_validity_part_2(int) do
    digit_list = String.split("#{int}", "", trim: true)
    with true <- is_proper_length?(digit_list),
         true <- has_only_two_same_adjacent_digits?(digit_list),
         true <- increasing_digit_vals?(digit_list) do
          true
         else
          _ -> false
         end
  end

  defp is_proper_length?(digit_list), do: length(digit_list) == 6
  defp has_same_adjacent_digits?(digit_list) do
    Enum.reduce_while(digit_list, nil, fn digit, last_val = _acc ->
      if (digit == last_val) do
        {:halt, true}
      else
        {:cont, digit}
      end
    end)
  end

  defp has_only_two_same_adjacent_digits?(digit_list) do
    digit_count_pairings = Enum.reduce(digit_list, [{0, 0}], fn digit, acc ->
      {last_digit, count} = List.last(acc)
      if (digit == last_digit) do
        acc = acc -- [{last_digit, count}]
        acc ++ [{last_digit, count + 1}]

      else
        acc ++ [{digit, 1}]
      end
    end)

    Enum.reduce_while(digit_count_pairings, nil, fn {digit, count}, _acc ->
      is_last_idx = List.last(digit_count_pairings) == {digit, count}
      cond do
        count == 2 -> {:halt, true}
        is_last_idx -> {:halt, false}
        true -> {:cont, nil}
      end
    end)


  end

  defp increasing_digit_vals?(digit_list) do
    Enum.reduce_while(digit_list, {0, 0}, fn digit, {last_digit, last_idx} ->
      cond do
        digit < last_digit -> {:halt, false}
        last_idx == length(digit_list) - 1 -> {:halt, true}
        true -> {:cont, {digit, last_idx + 1}}
      end
    end)
  end
end
