grow n | n == 0 = 1
       | n `mod` 2 /= 0 = 2 * grow (n - 1)
       | otherwise = 1 + grow (n - 1)
main = interact $ unlines . map (show . grow . (read :: String->Int)) . tail . words
