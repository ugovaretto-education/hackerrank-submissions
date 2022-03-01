parseInput [] = []
parseInput (bw:bwzs:xs) = [(map (read :: String->Int) $ words bw, map (read :: String->Int) $ words bwzs)] ++ parseInput xs
minCost ([b,w],[bc,wc,z]) | bc > wc + z = (wc + z) * b + wc * w
                          | wc > bc + z = bc * b + (bc + z) * w
                          | otherwise = bc * b + wc * w
main = interact $ unlines . map show . map minCost . parseInput . tail . lines
