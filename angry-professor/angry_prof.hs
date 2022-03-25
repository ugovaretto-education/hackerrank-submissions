cancel :: (Int, [Int]) -> String
cancel (_,[]) = "YES"
cancel (k,x) | k <= 0 = "YES"
             | (length . filter (<=0)) x < k = "YES"
             | otherwise = "NO"
parseInput [] = []
parseInput (sn:sk:as) =  let n = read sn :: Int
                             k = read sk :: Int
                             xs = map (read :: String -> Int) (take n as)
                         in (k,xs) : parseInput(drop n as)
main = interact $ unlines . (map cancel) . parseInput . drop 1 . words             




