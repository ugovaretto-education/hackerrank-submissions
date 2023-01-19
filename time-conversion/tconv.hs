timeConversion s = let [h1,h2,_,m1,m2,_,s1,s2,ap,_] = s
                       h = read [h1,h2]
                       rest = [':',m1,m2,':',s1,s2]
                    in if ap == 'A' then 
                        if h == 12 then "00" ++ rest
                        else take 8 s
                       else
                        if h == 12 then "12" ++ rest
                        else 
                            let h = ((read [h1,h2] :: Int) + 12)
                            in (show h) ++ [':',m1,m2,':',s1,s2]
main = do
        s <- getLine
        putStrLn $ timeConversion s
