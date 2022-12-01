amountDue (k,bill,c) = let t = sum bill
                           d = (t - (bill !! k)) `div` 2
                       in c - d
bonAppetit b = let d = amountDue b
               in if d == 0 then "Bon Appetit" else show d
parseInput s = let (n:k:rest) = map (read :: String->Int) . words $ s
                   items = take n rest
                   (b:_) = drop n rest
               in (k,items,b)
main = interact $ bonAppetit . parseInput
