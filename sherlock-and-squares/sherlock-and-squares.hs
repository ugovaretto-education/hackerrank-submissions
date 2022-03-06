
isSquare x = let s = round . sqrt . (fromIntegral :: Int -> Float) $ x
             in x == s * s
intRoot = round . sqrt . (fromIntegral :: Int -> Float) 
nextSquare x m = if isSquare x then intRoot x else if x == m then -1 else nextSquare (x + 1) m
prevSquare x m = if isSquare x then intRoot x else if x == m then - 1 else prevSquare (x - 1) m
squares [a,b] = let n = nextSquare a b
                    p = prevSquare b a
                in
                    if n < 0 then 0
                    else if n == p then 1
                         else p - n + 1
parseInput = tail . map (\x -> map (read :: String->Int) x) . map words . lines 
main = interact $ unlines . map (show . squares) . parseInput
