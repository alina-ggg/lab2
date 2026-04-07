defmodule Solution do
  def run do
    # Читаем ввод, разбиваем на слова и превращаем в числа
    input = IO.read(:all)
    numbers = String.split(input) |> Enum.map(&String.to_integer/1)

    case numbers do
      [n | tail] when n > 1 ->
        count_pairs(tail, 0)

      _ ->
        IO.puts(0)
    end
  end

  # Если в списке осталось 0 или 1 элемент — выводим результат
  defp count_pairs([], count), do: IO.puts(count)
  defp count_pairs([_last], count), do: IO.puts(count)

  # Сравниваем первые два элемента: current и next
  defp count_pairs([current, next | rest], count) do
    new_count = if current == next, do: count + 1, else: count
    # Передаем второй элемент (next) и хвост в следующий шаг
    count_pairs([next | rest], new_count)
  end
end

Solution.run()
