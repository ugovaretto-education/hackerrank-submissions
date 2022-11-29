defmodule Lisawbook do
  def solve(k, array) do
    IO.puts k
    IO.inspect array
    solver(0, k, array) 
  end
  defp solver(acc, _, []) do
    acc
  end
  defp solver(acc, k, [h | tail]) do
    if k == 3 do
      return 1
    end
    num_pages = div(h,k)
    {e, _} = Enum.reduce(1..num_pages, {0,1}, 
                    fn p, {e, page} ->
                      {e, page} = if page >= (p - 1) * k + 1 and page <= p * k do
                        {e + 1, page + 1}
                      else
                        {e, page + 1}
                      end
                      if rem(h,k) > 0 do
                        if page >= num_pages  * k + 1 and page <= num_pages * k + rem(h, k) do
                          {e + 1, page + 1}
                        else
                          {e, page + 1}
                        end
                      else
                        {e, page}
                      end
                    end
                    )
    solver(acc + e, k, tail)
  end    
end

[_n, k | array] = IO.read(:stdio, :all) |> String.split |> (Enum.map &String.to_integer/1)
IO.puts Lisawbook.solve(k, array) 
