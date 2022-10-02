
mport Data.Set as S
idx i lbs | S.lookupIndex i lbs == Nothing = idx i (S.insert i lbs)
          | otherwise = S.size lbs - S.findIndex i lbs
rankings (ll, scores) = [idx s ll | s <- scores]
parseInput ss =
  let (n : ns) = Prelude.map (read :: String -> Int) $ words ss
      lbs = Prelude.take n ns
      (_ : scores) = Prelude.drop n ns
   in (S.fromList lbs, scores)
main = interact $ unlines . Prelude.map show . rankings . parseInput
