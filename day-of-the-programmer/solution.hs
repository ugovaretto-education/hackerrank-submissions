import Text.Printf -- works with any number of days, any year not just with 256

monthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

monthDaysLeap = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

monthDays1918 = [31, 15, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

sumToSteps v xs = sumToSteps' v xs 0 0 -- assumption: positive v only

sumToSteps' _ [] _ n = n
sumToSteps' v (x : xs) acc n
  | acc >= v = n
  | otherwise = sumToSteps' v xs (acc + x) (n + 1)

monthDay n y =
  let chunks
        | y == 1918 = monthDays1918
        | leap y = monthDaysLeap
        | otherwise = monthDays
      pm = sumToSteps n chunks
      days = sum . take pm $ chunks
      (m, d) = (pm, chunks !! (pm - 1) - (days - n))
   in (d, m, y)

leap :: Int -> Bool
leap y
  | y < 1918 = y `mod` 4 == 0
  | otherwise = y `mod` 400 == 0 || (y `mod` 4 == 0 && y `mod` 100 /= 0)

formatDate :: (Int, Int, Int) -> String
formatDate (day, month, year) = printf "%02d.%02d.%d" day month year

main = interact $ formatDate . monthDay 256 . (read :: String -> Int)
