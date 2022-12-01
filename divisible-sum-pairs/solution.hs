-- O(n^2)
-----------------------------------------------------------------------------------------
--divk (k,xs) = let divk' :: [Int] -> [Int] -> Int -> Int
--                  divk' _ [] acc = acc
--                  divk' [] (x:rs) acc = divk' [x] rs acc
--                  divk' ls (x:rs) acc = divk' (ls ++ [x]) rs 
--                        (acc + (length . filter ((==0) . (`mod` k) . (+x))) ls)
--               in divk' [] xs 0  
--parseInput s = let (_:k:arr) = (map (read :: String->Int) . words) s
--               in (k,arr)
--main = interact $ show . divk . parseInput 

------------------------------------------------------------------------------------------`
-- O(n), only number of elements per mod k is stored in array
--import Data.Array (Array, array, (!), (//))
--divk (k, ns) =
--let buckets = array (0, k -1) [(i, 0) | i <- [0 .. k -1]]
--      divk' :: [Int] -> Array Int Int -> Int -> Int
--      divk' [] _ acc = acc
--      divk' (x : xs) bs acc = --
--        let modK = x `mod` k
--            n = if modK == 0
--                then bs ! 0
--                else sum [e | i <- [1 .. k -1], let e = bs ! i, i + modK == k]
--         in divk' xs (bs // [(modK, (bs ! modK) + 1)]) acc + n
--   in divk' ns buckets 0
--parseInput s =
--  let (_ : k : arr) = (map (read :: String -> Int) . words) s
--   in (k, arr)
--main = interact $ show . divk . parseInput

-----------------------------------------------------------------------------------------
-- O(n) - with Sequence instead of Array
import Data.Sequence as S (Seq, filter, replicate, index, update, mapWithIndex)
divk :: (Int, [Int]) -> Int
divk (k, ns) =
  let buckets = S.replicate k 0
      divk' :: [Int] -> Seq Int -> Int -> Int
      divk' [] _ acc = acc
      divk' (x : xs) bs acc =
        let modK = x `mod` k
            n = if modK == 0
                then index bs 0
                else sum . mapWithIndex (\i e -> if i + modK == k then e else 0) $ bs 
         in divk' xs (update modK (index bs modK + 1) bs) acc + n
   in divk' ns buckets 0

parseInput :: [Char] -> (Int, [Int])
parseInput s =
  let (_ : k : arr) = (map (read :: String -> Int) . words) s
   in (k, arr)

main :: IO ()
main = interact $ show . divk . parseInput
