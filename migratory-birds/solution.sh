import Data.Sequence as S
histogram bs = let hist = S.replicate 6 0
                   mb :: [Int] -> S.Seq Int -> S.Seq Int
                   mb [] s = s
                   mb (i:xs) h = mb xs (update i (index h i + 1) h)
               in mb bs hist
migratoryBirds bs = let hist = histogram bs
                        idx = elemIndicesL (maximum hist) hist
                    in head idx
main = interact $ show . migratoryBirds . map (read :: String->Int) . tail . words 
