reverseNum n = let (_,x) = span (== '0') (reverse (show n))
               in (read :: String -> Int) x
beautifulDays [i,j,k] = length . filter (\x -> (abs (reverseNum x) - x) `mod` k == 0) $ [i..j]
main = interact $ show . beautifulDays . map (read :: String->Int) . words
