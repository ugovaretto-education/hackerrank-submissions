segments (n, s, xs) = [1 | i <- [0 .. (length xs - n)], let xns = take n (drop i xs), sum xns == s]

parseInput ts =
  let (n : xs) = (map (read :: String -> Int) . words) ts
      arr = take n xs
      (s : n' : _) = drop n xs
   in (n', s, arr)

main = interact $ show . length . segments . parseInput
