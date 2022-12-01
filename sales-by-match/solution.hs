
module Main where
import qualified Data.Map as M
inc :: (Ord a, Num b, Eq a, Eq b) => a -> b -> M.Map a b -> M.Map a b
inc k i = M.alter (\x -> if x == Nothing then Just i else (+1) <$> x) k
hist :: [Int] -> M.Map Int Int
hist = foldr (\k m -> inc k 1 m)  M.empty

socks :: [Int] -> Int
socks xs = let h = hist xs
           in sum $ M.elems $ M.map (`div` 2)  h
main = interact $ show . socks . map (read :: String->Int) . tail . words
