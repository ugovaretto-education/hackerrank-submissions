defmodule Lisawbook do
  def solve(k, array) do
    solver(0, k, array)
  end

  defp solver(acc, _, []) do
    acc
  end

  defp solver(acc, k, [h | tail]) do
    num_pages = div(h, k)

    {e, page} =
      if num_pages > 0 do
        Enum.reduce(1..num_pages, {0, 1},
        fn p, {e, page} ->
            if page >= (p - 1) * k + 1 and page <= p * k do
              {e + 1, page + 1}
            else
              {e, page + 1}
            end
        end)
      else
        {0, 1}
      end
    e2 = 
      if rem(h, k) > 0 do
        if page >= num_pages * k + 1 and page <= num_pages * k + rem(h, k) do
          e + 1
        else
          e
        end
      else
        e
      end

    solver(acc + e2, k, tail)
  end
end

[_n, k | array] = IO.read(:stdio, :all) |> String.split() |> Enum.map(&String.to_integer/1)
IO.puts(Lisawbook.solve(k, array))
