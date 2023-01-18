[n, _ | xs] = IO.read(:stdio, :all) |> String.split |> Enum.map(&String.to_integer/1)
IO.puts Enum.map(0..n, fn x -> Enum.map(xs, fn y -> abs(y - x) end) |> Enum.min end) |> Enum.max
