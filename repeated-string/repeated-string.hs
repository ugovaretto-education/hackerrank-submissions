count _ [] = 0
count e (x:xs) | e == x = count e xs + 1
               | otherwise = count e xs
numA (xs,n) = let a = count 'a' xs
                  na = a * (n `div` length xs)
                  r = n `mod` length xs
                in count 'a' (take r xs) + na
parseInput [xs,n] = (xs,read n :: Int)
main = interact $ show . numA . parseInput . lines
