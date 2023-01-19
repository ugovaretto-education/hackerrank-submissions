betweenSets (a,b) =
    let da = [n | n <- [minimum a..minimum b], all ((==0) . (mod n)) a]
        bd = [x | x <- da, all ((==0) . (`mod` x)) b]
    in length bd
parseInput s = let (n:_:rest) = (map (read :: String->Int) . words) s
               in (take n rest, drop n rest)
main = interact $ show . betweenSets . parseInput
