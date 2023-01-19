module Main where
main = do
         ns <- getLine
         let n = read ns
         putStr $ unlines $ [replicate (n-i) ' ' ++ replicate i '#' | i <- [1..n]]
