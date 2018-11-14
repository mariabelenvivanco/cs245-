{- Name: <Maria Vivanco
   File : Lab3.hs
   Desc: Excersizes for Lab 3
-}

module Main where

import Data.List
import Data.Char

main :: IO ()
main = do
  putStrLn "Hello"

divides :: Integer -> Integer -> Bool
divides y x = (x `mod` y == 0)

factors :: Integer -> [Integer]
factors 1 = [1]
factors n = filter (divides n) [1..n]
            --where
            --  d = n-1
