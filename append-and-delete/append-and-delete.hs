prefixLen xs ys = length $ takeWhile (== True) $ zipWith (==) xs ys
suffixLen xs ys = (length $ drop n xs, length $ drop n ys) 
                    where
                        n = prefixLen xs ys
check (xs, ys, 0) = xs == ys
check (xs,ys,k) = let 
                    (s, t) = suffixLen xs ys
                    st = s + t
                  in 
                    if k == st || (k > st && (k-st) `mod` 2 == 0) || 
                      (st > 1 && k > st && k `mod` st == 0) || 
                      (length xs + length ys <= k) then True
                    else False            
out x | x == True = "Yes"
      | otherwise = "No"
parseInput lss = let [xs, ys, n] = lines(lss)
                 in (xs, ys, read n :: Int)    
main = interact $ out . check . parseInput

