import Data.Array as A
import Data.List as L
import Prelude as P
trim  = P.filter (/= ' ')
nextMul (m1, m2) n = if m1 * m2 >= n then (m1,m2)
                     else if m1 == m2 then nextMul (m1,m2+1) n
                     else nextMul (m1+1,m2) n
encrypt xs = let n = floor $ sqrt (fromIntegral $ length xs) :: Int
                 (h',w') = nextMul (n,n) (length xs)
                 h = min h' w'
                 w = max h' w'
                 xs' = xs ++ replicate (w*h-length xs) ' '
                 es = A.array ((0,0),(h-1,w-1)) [((r,c),xs' !! (r * w + c) ) | r <- [0..h-1], c <- [0..w-1]]
                 tes = [[es ! (r,c) | r <- [0..h-1]] | c <- [0..w-1]]
             in  L.intercalate " " (map trim tes)
main = interact $ encrypt . trim . head . lines
