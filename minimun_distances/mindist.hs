import qualified Data.Map as M
maxInt = maxBound :: Int
-- dist = (index, distance from previous index)
updateSet (i,s) e = case M.lookup e s of
                         Nothing -> (i+1, M.insert e (i,maxInt) s)
                         Just (i',d) -> if i - i' < d then (i+1, M.insert e (i', i-i') s)
                                       else (i+1, s)
computeMinDist xs = let (_,s) = foldl updateSet (0, M.empty) xs
                        d = foldl (\x (_,y) -> min x y) maxInt (M.elems s)
                    in if d == maxInt then -1 else d
main = interact $ show . computeMinDist . map (read :: String->Int) . words . head . tail . lines
