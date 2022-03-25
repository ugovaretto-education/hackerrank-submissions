
candy [n,m,s] = (s - 1 + m - 1) `mod` n + 1
go (_:xs) = map (\l -> show . candy . map (read :: String->Int). words $ l) xs
main = interact $ unlines . go . lines
