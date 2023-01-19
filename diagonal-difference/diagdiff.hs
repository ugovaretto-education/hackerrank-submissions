
{-# LANGUAGE DuplicateRecordFields, FlexibleInstances, UndecidableInstances #-}

module Main where

import Control.Monad
import Data.Array
import Data.Bits
import Data.List
import Data.List.Split
import Data.Set
import Data.Text
import Debug.Trace
import System.Environment
import System.IO
import System.IO.Unsafe

--
-- Complete the 'diagonalDifference' function below.
--
-- The function is expected to return an INTEGER.
-- The function accepts 2D_INTEGER_ARRAY arr as parameter.
--
tailCols :: [[a]] -> [[a]]
tailCols [] = []
tailCols ([]:_) = []
tailCols ([_]:_) = []
tailCols m = Prelude.map Prelude.tail m

tailRows :: [[a]] -> [[a]]
tailRows = Prelude.tail

diag :: [[a]] -> [a]
diag [] = []
diag m = (Prelude.head . Prelude.head) m : (diag . tailCols . tailRows) m 

upperDiags :: [[a]] -> [[a]]
upperDiags m = (diag . tailCols) m : (upperDiags . tailCols) m

lowerDiags :: [[a]] -> [[a]]
lowerDiags m = (diag . tailCols) m : (lowerDiags . tailRows) m

mirrorCol :: [[a]] -> [[a]]
mirrorCol = Prelude.map Prelude.reverse

diagonalDifference arr = let d1 = sum (diag arr)
                             d2 = (sum . diag . mirrorCol) arr
                             in abs (d1 - d2)

lstrip = Data.Text.unpack . Data.Text.stripStart . Data.Text.pack
rstrip = Data.Text.unpack . Data.Text.stripEnd . Data.Text.pack

readMultipleLinesAsStringArray :: Int -> IO [String]
readMultipleLinesAsStringArray 0 = return []
readMultipleLinesAsStringArray n = do
    line <- getLine
    rest <- readMultipleLinesAsStringArray(n - 1)
    return (line : rest)

main :: IO()
main = do
    stdout <- getEnv "OUTPUT_PATH"
    fptr <- openFile stdout WriteMode

    nTemp <- getLine
    let n = read $ lstrip $ rstrip nTemp :: Int

    arrTemp <- readMultipleLinesAsStringArray n
    let arr = Data.List.map (\x -> Data.List.map (read :: String -> Int) . Data.List.words $ rstrip x) arrTemp

    let result = diagonalDifference arr

    hPutStrLn fptr $ show result

    hFlush fptr
    hClose fptr
