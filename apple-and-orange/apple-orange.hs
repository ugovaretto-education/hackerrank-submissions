appleOranges arr = 
                let [s,t,a,b,m,n] = (map (read :: String->Int) . take 6) arr
                    rest = map read (drop 6 arr)
                    apples = (map (+a) . take m) rest
                    oranges = (map (+b) . drop m) rest
                    apples' = (length . filter (\x -> x >= s && x <= t)) apples
                    oranges' = (length . filter (\x -> x >= s && x <= t)) oranges
                in [apples', oranges']
main = interact $ unlines . map show . appleOranges . words    
