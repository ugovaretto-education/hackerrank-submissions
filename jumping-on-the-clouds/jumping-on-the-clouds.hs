jump' n [] = n
jump' n [_] = n
jump' n [_,1,_] = n + 1
jump' n [_,_] = n + 1 
jump' n (x:y:z:xs) | z == 1 = jump' (1+n) (y:z:xs)
                   | otherwise = jump' (1+n) (z:xs)
jump xs = jump' 0 xs
main = interact $ show . jump . map (read :: String->Int) . tail . words
