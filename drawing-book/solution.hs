numTurns [np,p] = min (p `div` 2) ((np + (np+1) `mod` 2  - p) `div` 2)
main = interact $ show . numTurns . map (read :: String->Int) . words
