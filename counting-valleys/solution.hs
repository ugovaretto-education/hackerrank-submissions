valley xs = let ys = scanl1 (+) xs
            in length [ True  | (x,xd) <- zip ys (tail ys), x < 0 && xd >= 0]
main = interact $ show . valley . map (\x -> if x == 'D' then -1 else 1) . concat . tail . words
