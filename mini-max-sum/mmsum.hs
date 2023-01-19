module Main where
import Text.Printf

sumElems :: Num a => [a] -> [a] -> [a] -> [a]
sumElems _ [] prev = prev
sumElems [] (x:rs) [] = let s = [sum rs] in sumElems [x] rs s 
sumElems ls (x:rs) prev = let s = prev ++ [(sum ls) + (sum rs)] in sumElems (ls ++ [x]) rs s 

miniMaxSum arr = let sums = sumElems [] arr []
 --                in printf "%d %d" (minimum sums) (maximum sums)
                 in putStrLn $ (show (minimum sums)) ++ " " ++ (show (maximum sums)) 

main :: IO()
main = do
    arrTmp <- getLine
    let arr = map read (words arrTmp)
    miniMaxSum arr
