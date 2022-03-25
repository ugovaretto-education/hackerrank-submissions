
digs = reverse . digs' where
       digs' 0 = []
       digs' x' = x' `mod` 10 : digs' (x' `div` 10) 
ndiv n = foldr (\x a -> if x /= 0 && n `mod` x == 0 then a + 1 else a) 0 (digs n)
main = interact $ unlines . map (show . ndiv . (read ::String->Int)) . tail . words
