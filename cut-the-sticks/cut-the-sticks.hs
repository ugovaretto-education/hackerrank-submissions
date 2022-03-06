import qualified Data.List as L (sort)
cut xs = cut' xs [] where
            cut' [] rs = rs
            cut' [x] rs = rs ++ [1]
            cut' (x:xs') cs = let rs = filter (/=0) . map (subtract x) $ xs'
                                  l = length (x:xs')
                                  ys = cs ++ [l]
                             in cut' rs ys

main = interact $ unlines . map show . cut . L.sort . map (read :: String->Int) . tail . words
