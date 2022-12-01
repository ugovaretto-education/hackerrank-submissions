mostLeast :: [Int] -> [Int]
mostLeast xs =
  let mostLeast' :: [Int] -> [Int] -> (Int, Int) -> (Int, Int)
      mostLeast' _ [] prev = prev
      mostLeast' [] (x : rs) prev = mostLeast' [x] rs prev
      mostLeast' ls (x : rs) (m, l) =
        let m' =
              if x > maximum ls
                then m + 1
                else m
            l' =
              if x < minimum ls
                then l + 1
                else l
         in mostLeast' (ls ++ [x]) rs (m', l')
      (x, y) = mostLeast' [] xs (0, 0)
   in [x, y]

main = interact $ unwords . map show . mostLeast . map (read :: String -> Int) . tail . words
