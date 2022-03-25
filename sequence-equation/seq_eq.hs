perm xs = [y + 1 | x <- [0..(length xs - 1)], y <- [0..(length xs - 1)], (xs !! (xs !! y)) == x]
main = interact $ unlines . map  show . perm . map (subtract 1) . map (read :: String->Int) . tail . words
