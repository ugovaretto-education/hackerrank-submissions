
jumpOnCloud [] = 0
jumpOnCloud [_] = 0
jumpOnCloud (n : k : xs) =
  let t = foldl (
            \(y, i) x -> 
                if i `mod` k == 0 && x == 1 then (y + 2, i + 1) else (y, i + 1)) (0, 0) xs
  in 100 - (n `div` k + fst t)
main = interact $ show . jumpOnCloud . (map (read :: String -> Int) . words)
