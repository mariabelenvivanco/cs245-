{- Name: Maria Vivanco
 File: Lexer.hs
 Desc: A Java lexer
-}
module Main where

import Data.Char
import System.Environment
import System.Exit
import System.FilePath

main :: IO ()
main = do
   args <- getArgs
   filename <- checkArgs args
   input <- readFile filename
   let result = lexJava input
   writeFile (takeBaseName filename <.> "lex") (unlines result)
-- Check the command-line arguments. Returns the filename
-- to lex upon success.
checkArgs :: [String] -> IO FilePath
checkArgs [path] = pure path
checkArgs _other = do
   putStrLn "Usage: ./Lexer <filename>.java"
   putStrLn "Writes to <filename>.lex"
   exitFailure
-- Takes Java code as input and returns a list of Strings.
-- Each String in the output list is one Java token.
-- Comments and whitespace are discarded.
lexJava :: String -> [String]
lexJava str = [str] -- You will edit this line
