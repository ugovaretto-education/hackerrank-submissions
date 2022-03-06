parseInput = map (map (read :: String->Int) . words) . lines
fine [[retDay,retMonth,retYear],[dueDay,dueMonth,dueYear]] 
    | retYear > dueYear = 10000
    | retYear < dueYear = 0
    | retMonth > dueMonth &&  retYear == dueYear = 500 * (retMonth - dueMonth)
    | retDay > dueDay && retMonth == dueMonth = 15 * (retDay - dueDay)
    | otherwise = 0
main = interact $ show . fine . parseInput
