virtAd 1 = (2,2)
virtAd d = let (l,c) = virtAd (d-1)
               s' = l * 3
               l' = s' `div` 2
               c'= c + l'
           in (l',c')
main = interact $ show . snd . virtAd . (read :: String->Int ) . head . words
