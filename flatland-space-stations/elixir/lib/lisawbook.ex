defmodule Lisawbook do
  def solve(0, _) do
    0
  end
  def solve(_, []) do
    0
  end
  def solve(k, array) do
    solver(0, k, 1, array)
  end

  defp solver(acc, _, _, []) do
    acc
  end

  defp solver(acc, k, page, [h | tail]) do
    num_pages = div(h, k)

    {e, page} =
      if num_pages > 0 do
        Enum.reduce(1..num_pages, {0, page},
        fn p, {e, page} ->
            if page >= (p - 1) * k + 1 and page <= p * k do
              {e + 1, page + 1}
            else
              {e, page + 1}
            end
        end)
      else
        {0, page}
      end
    {e2, page} = 
      case {num_pages, rem(h, k)} do
        {_, 0} -> {e, page}
        {np, r} -> if page >= np * k + 1 and page <= np * k + r do
                    {e + 1, page + 1}
                   else
                    {e, page + 1}
                   end
      end
    solver(acc + e2, k, page, tail)
  end
end

[_n, k | array] = IO.read(:stdio, :all) |> String.split() |> Enum.map(&String.to_integer/1)
IO.puts(Lisawbook.solve(k, array))
