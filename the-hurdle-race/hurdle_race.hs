
main = interact $ show . doses . parseInput
parseInput s = let (_:k:h) = map (read :: String->Int) . words $ s in (k,h)
doses (k,h) = max (maximum h - k) 0
