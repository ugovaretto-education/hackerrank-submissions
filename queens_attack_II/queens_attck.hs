-- ^ Y                                                                    
-- |                                                       
-- |              
-- |                                                           
-- |                                         
-- |                   X                                      
-- -------------------->
import Data.Set as S                                
import Prelude as P  

parseInput :: [String] -> ((Int, Int), Int, Int, [[Int]])
parseInput xs =                                                           
  let ([s,ob]:[r,c]:ys) = P.map (P.map (read :: String -> Int) . words) xs
   in ((r,c), s, ob, S.toList $ S.fromList ys)
                                              
                                                  
center :: Num b => ((b,b), [[b]]) -> [(b, b)]                
center ((r, c), xs) = P.map (\[r', c'] -> (c' - c, r' - r)) xs
                                 
type Dirs = (Int, Int, Int, Int, Int, Int, Int, Int)
type Pos = (Int, Int)                                        
                                                             
filterObstacles :: [Pos] -> [Pos]                           
filterObstacles = P.filter (\(x, y) -> x == 0 || y == 0 || abs x == abs y)
                                                           
initDirs :: Int -> Pos -> Dirs                             
initDirs s (y, x) = (s -y, min (s - x) (s -y),              
                    s - x, min (s - x) (y-1), y-1,          
                    min (x -1) (y-1), x -1, min (x -1) (s-y))

updateDirs :: Dirs -> Pos -> Dirs
updateDirs (n, nw, w, sw, s, se, e, ne) (x, y)   
  | x == 0 && y < 0 = (n, nw, w, sw, min s (-y-1), se, e, ne)
  | x == 0 && y > 0 = (min (y-1) n, nw, w, sw,  s, se, e, ne)
  | y == 0 && x < 0 = (n, nw, w, sw, s, se,min e (-x-1), ne)
  | y == 0 && x > 0 = (n, nw, min (x-1) w, sw, s, se, e, ne)
  | x > 0 && y < 0 = (n, nw, w, min sw (x-1), s, se, e, ne)
  | x > 0 && y > 0 = (n, min nw (x-1), w, sw, s, se, e, ne)
  | x < 0 && y < 0 = (n, nw, w, sw, s, min se (-x-1), e, ne)
  | x < 0 && y > 0 = (n, nw, w, sw, s, se, e, min ne (-x-1))                  
  | otherwise = (n, nw, w, sw, s, se, e, ne)                     

             
sumDirs :: Num a => (a, a, a, a, a, a, a, a) -> a             
sumDirs (a,b,c,d,e,f,g,h) = a + b + c + d + e + f + g + h                                                                                                                                    
                                                                                                                                                                                             
closestObstacles :: (Pos, Int, Int, [[Int]]) -> Int                                                                                                                                          
closestObstacles (q, 0, _, _) = 0                                                                                                                                                            
closestObstacles (q, 1, _, _) = 0                                                                                                                                                            
closestObstacles (q, s, 0, _) = sumDirs $ initDirs s q
closestObstacles (q, s, _, []) = sumDirs $ initDirs s q                   
closestObstacles (q, s, ob, xs)  = sumDirs . P.foldl updateDirs (initDirs s q)
                               . filterObstacles $ center (q, xs)

main :: IO ()                                
main = interact $ show . closestObstacles . parseInput . lines
