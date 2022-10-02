
import Data.Map as M
main = interact $ show . area . parseInput 
parseInput s = (Prelude.map (read :: String->Int) . Prelude.take 26 $ words s, head $ Prelude.drop 26 $ words s)
area (heights,w) = let h = M.fromList $ zip ['a'..'z'] heights
                   in length w * Prelude.foldr (\x a -> if h ! x > a then h ! x else a) 0 w
