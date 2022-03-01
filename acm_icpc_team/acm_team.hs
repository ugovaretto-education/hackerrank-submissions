import Data.Char(digitToInt)
groupByTwo [] = []
groupByTwo (x:xs) = map ((,) x) xs ++ groupByTwo xs
maxTopics = map (\(l,r) -> sum $ zipWith max l r) . groupByTwo
acmGroups gs = let ms = maxTopics gs
                   m = maximum ms
               in [m, length $ filter (==m) ms]
parseInput = map (map digitToInt)
main = interact $ unlines . map show . acmGroups . parseInput . tail . lines
