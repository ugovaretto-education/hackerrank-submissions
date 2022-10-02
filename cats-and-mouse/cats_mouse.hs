import Control.Monad
catAndMouse a b c | abs (a-c) == abs (c-b) = "Mouse C" 
                  | abs (a-c) < abs (b-c) = "Cat A"
                  | otherwise = "Cat B"
main = do
    q <- readLn :: IO Int
    forM_ [1..q] $ \_ -> do line <- getLine
                            let (x:y:z:_) = map (read :: String->Int) . words $ line
                            putStrLn $ catAndMouse x y z
