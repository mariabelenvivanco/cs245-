{- Author: Maria Vivanco
  Assignment 5 Part 2: Question 7.
  File: Guess.hs
  Contain	the	implementation	of	a	guessing	game
-}


module Main where


import System.Random
import Text.Read

main :: IO ()
main = do
  -- chooses a random number btwn 1-10
  number <- randomRIO(1,10)
  -- allow	the user to	try to guess the number,reporting	when	she	guesses	correctly
  guessingGame "Guess the number I've chosen between 1 & 10" number

prompt :: String -> IO String -- prompt function from Do.hs
prompt query = do
 putStrLn query
 answer <- getLine
 pure answer


guessingGame :: String -> Integer ->  IO ()
guessingGame query numberPicked = do -- monadic function
  answer <- prompt query -- answer Type : IO String
  case readMaybe answer of -- convert to Maybe Integer
    Nothing -> do
      putStrLn "Invalid input: input an integer"
      guessingGame query numberPicked
    Just answer -> case answer == numberPicked of -- if answer is valid input, check if input and number chosen are equal
      True -> putStrLn "you won"
      False ->  do
        putStrLn "Wrong number"
        guessingGame query numberPicked
