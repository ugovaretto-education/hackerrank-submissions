
{-# LANGUAGE DuplicateRecordFields, FlexibleInstances, UndecidableInstances #-}

module Main where

import Control.Monad
import Data.Array
import Data.Bits
import Data.List hiding (length, filter)
import Data.List.Split
import Data.Set hiding (length, filter, map)
import Data.Text  hiding (length, filter, unlines, map, tail)
import Debug.Trace
import System.Environment
import System.IO
import System.IO.Unsafe
import Text.Printf
--
-- Complete the 'plusMinus' function below.
--
-- The function accepts INTEGER_ARRAY arr as parameter.
--
toFloatStr :: PrintfArg a => a -> String
toFloatStr x = (printf "%.6f" x)

plusMinus arr = let np = length $ filter (>0) arr
                    nn = length $ filter (<0) arr
                    nz = length $ filter (==0) arr
                    l = (fromIntegral . length) arr
            in putStr $ unlines $ map toFloatStr $ 
                        map ((/l) . (\x -> (fromIntegral x) :: Float)) [np,nn,nz]
    -- Write your code here

lstrip = Data.Text.unpack . Data.Text.stripStart . Data.Text.pack
rstrip = Data.Text.unpack . Data.Text.stripEnd . Data.Text.pack

main :: IO()
main = do
    nTemp <- getLine
    let n = read $ lstrip $ rstrip nTemp :: Int

    arrTemp <- getLine

    let arr = Data.List.map (read :: String -> Int) . Data.List.words $ rstrip arrTemp

    plusMinus arr
