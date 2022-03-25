import Data.Sequence as S
parse (x:y:xs) = let [_,r,_] = map (read :: String -> Int) . words $ x
                     vs = map (read :: String -> Int) . words $ y
                     qs = map (read :: String -> Int) xs
                 in (r,vs,qs)
go (_,_,[]) = []
go (r,vs,qs) = let rs = S.fromList vs 
                   l = S.length rs
                   in [S.index rs ((i + r*(l - 1)) `mod` l)  | i <- qs]
main = interact $ unlines . map show . go . parse . lines
                      
