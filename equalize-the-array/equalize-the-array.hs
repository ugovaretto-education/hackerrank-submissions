import Data.Map as M
import Data.List as L
findDuplicates xs = M.fromListWith (+) $ zip xs (L.map (const 1) xs)
numDel xs = let d = findDuplicates xs
                n = maximum $ M.elems d
            in length xs - n
main = interact $ show . numDel . L.map (read :: String->Int) . tail . words
