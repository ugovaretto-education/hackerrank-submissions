module Main where

birthdayCakeCandles :: (Num a, Ord a) => [a] -> Int
birthdayCakeCandles candles = (length . filter (== maximum candles)) candles
                              
main = do
        _ <- getLine
        tmpArr <- getLine
        putStrLn $ show $ birthdayCakeCandles (map read (words tmpArr)) 
