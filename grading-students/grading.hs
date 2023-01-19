next5 :: Int -> Int
next5 x | x `mod` 5 == 0 = x
        | otherwise = ((x `div` 5) + 1) * 5
roundGrade :: Int -> Int
roundGrade x | x >= 38 && (next5 x - x < 3) = next5 x 
             | otherwise = x
main = interact (unlines . map show . map roundGrade . map (read :: String->Int) . tail . words)
