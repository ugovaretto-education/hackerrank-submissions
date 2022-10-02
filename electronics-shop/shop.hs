
parseInput s = let (v:n:_:rest) = map (read :: String->Int) . words $ s
               in (v, take n rest, drop n rest)
budget (v,xs,ys) = let b = filter (<=v) $ pure (+) <*> xs <*> ys
                   in if null b then -1 else maximum b
main = interact $ show . budget . parseInput
