
jumps input = let [x1, v1, x2, v2] = (map (read :: String->Int) . words) input
              in if v1 <= v2 then "NO"
                 else if ((x2 - x1) `mod` (v2 - v1) == 0)
                      then "YES" else "NO"
main = interact $ jumps
