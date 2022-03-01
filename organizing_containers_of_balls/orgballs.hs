import Data.Array as A
parseNum :: String -> [Int]
parseNum xs = let ws = words xs
              in map (read:: String->Int) ws
parseInput :: [String] -> [[[Int]]]
parseInput [] = []
parseInput (x:xs) = let n = (read :: String->Int) x
                        ts = take n xs
                    in [map parseNum ts] ++ parseInput (drop n xs)
-- inputToMatrix :: [[Int]] -> Bool
inputToMatrix xs = let n = length $ head xs
                       sumCols = [sum [xs !! r !! c | r <- [0..n-1]] | c <- [0..n-1]]
                       sumRows = [sum [xs !! r !! c | c <- [0..n-1]] | r <- [0..n-1]]
                       xx = A.array ((0,0),(n-1,n-1)) [((r,c), sumRows !! r == sumCols !! c) | r <- [0..n-1], c <- [0..n-1] ]
                       rs = [length $ filter (==True) [xx A.! (r,c) | c <- [0..n-1]] | r <- [0..n-1]]
                       cs = [length $ filter (==True) [xx A.! (r,c) | r <- [0..n-1]] | c <- [0..n-1]]
                   in all (>0) rs && all (>0) cs
toOutput :: Bool -> String
toOutput x | x == False = "Impossible"
           | otherwise = "Possible"
main = interact $ unlines . map toOutput . map  inputToMatrix . parseInput . tail . lines
