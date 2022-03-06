
import Data.List as L
import Data.Map as M
-- no preallocated static vector only use maps
remainders k xs = let m = M.fromListWith (+) $
                         zip (L.map (`mod` k) xs) (L.map (const 1) xs)
                 in M.mapWithKey (\r a -> if r == 0 || (r == k `div` 2 && even k) 
                                          then 1 else a) m
upperHalf k = M.filterWithKey (\r _ -> r > k `div` 2)
lowerHalf k = M.filterWithKey (\r _ -> r <= k `div` 2)
lohi xm ym | M.size xm > M.size ym = (ym,xm)
           | otherwise = (xm,ym)
-- need to add to elements with remainder < k/2 the missing elements with remainders k-r 
-- where r > k/2 with 0 elements in the map element value in order to have them 
-- compared with the elements with remainder > k/2
-- example: k = 9 
-- remainder < k/2: [(2,1),(3,2)]
-- remainder >= k/2: [(5,1),(7,2)]
-- (5,1) will not be considerd because there is no element 4 in the first array 
-- and therefore 9-4 won't be taken into account
-- adding [4,0] to the first array fixes the problem: [(2,1),(3,2),(4,0)]
fillK k l g = M.foldrWithKey (\r a acc -> if M.member (k - r) l 
                                          then acc 
                                          else M.insert (k-r) 0 acc) M.empty g   
maxSize k l g = M.foldr (+) 0 $
                M.mapWithKey (\r a ->
                        let x = M.findWithDefault a (k-r) g
                        in if x > a then x else a) l
maxSet(_,0) = 0
maxSet(_,1) = 1
maxSet (xs,k) = let r = remainders k xs
                    (lm,hm) = lohi (lowerHalf k r) (upperHalf k r)
                in maxSize k (M.union lm $ fillK k lm hm) hm
parseInput (x:xs) = let [_,k] = L.map (read :: String->Int) $ words x 
                        ys = L.map (read :: String->Int) . words $ head xs
                    in (ys,k) 
main = interact $ show . maxSet . parseInput . lines 
