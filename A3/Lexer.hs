
{-Maria Vivanco
 File: Lexer.hs
 Desc: A Java lexer
-}
module Main where

import Data.Char
import System.Environment
import System.Exit
import System.FilePath
import Data.Array
import Data.List
import Data.Maybe
import qualified Data.Text as T
import Data.Char

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

-- 
-- lexJava :: String -> [String]
-- --lexJava str = map (:[]) str --split all of the elements  -- source StackOverFlow
-- lexJava str = lexNoPrefix (findToken str)
--
-- lexNoPrefix :: String -> [String]
-- lexNoPrefix [] = [] -- string is empty
-- lexNoPrefix (x:xs) = token : lexJava rest -- add token from lex1 pair to an array of tokens
--   where
--     (token,rest) = lex1 x xs -- match token and rest to the result of lex1 (x:xs)
--
-- lex1 :: Char -> String -> (String, String) -- (token, restofString)
-- --  ex: lex1 'v' "arName++ - > ("varName", "++;")
-- lex1 x xs
--   |isLetter x = (identToken, rest)
--   |otherwise = lex1 (head xs) xs
--     where
--       s = T.pack (x:xs)
--       start = T.pack (identifier (x:xs))
--       identToken = T.unpack (fst (T.breakOnEnd start s))
--       rest  = T.unpack (snd (T.breakOnEnd start  s))
--
--
--
-- breakPoint  :: String -> Char -- bug
-- breakPoint (x:xs)
--     |isLetter x == False = x
--     |isDigit  == False = x
--     |isOperator x == False = x
--     |otherwise = breakPoint xs
--
--
-- identifier :: String -> String
-- identifier [] = []
-- identifier (x:xs) = fst (break (==breakPoint (x:xs)) (x:xs))
--
-- --isOperator :: String -> Bool
-- --if x is one of these -> return true
-- --return false if not g
-- -- =   >   <   !   ~   ?   :   ->
-- -- ==  >=  <=  !=  &&  ||  ++  --
-- -- +   -   *   /   &   |   ^   %   <<   >>   >>>
-- -- +=  -=  *=  /=  &=  |=  ^=  %=  <<=  >>=  >>>=
--
--
-- findToken :: String -> String -- returns string after irrevelant characters: comments and white spaces
-- -- ex: "/*comment*/hi //comment \n" -> "hi //comment\n"
-- findToken [] = []
-- findToken (x:xs) = token
--   where
--     noSpace = deleteWhiteSpace (x:xs)
--     noComment = removeBlockComment noSpace
--     token  = removeSingleLine noComment
--
--   -- |isSpace x = deleteWhiteSpace (x:xs)
--   -- |x == '/' && head xs == '*'  = removeBlockComment (x:xs)
--   -- |x == '/' && head xs == '/'  = removeSingleLine (x:xs)
--   -- |otherwise = findToken xs
--
-- deleteWhiteSpace :: String -> String
-- deleteWhiteSpace "" = ""
-- deleteWhiteSpace (x:xs)
--   |isSpace x = filter (/=x) xs
--   |otherwise = (x:xs)

removeBlockComment :: String -> String -- worked w mikal
removeBlockComment "" = ""
removeBlockComment (x:xs)
  |x == '/' && head xs == '*' = beforeComment ++ afterComment
  |otherwise = (x:xs)
    where
      s = T.pack (x:xs)
      start = T.pack "/*"
      end = T.pack "*/"
      beforeComment = T.unpack (fst (T.breakOn start s))
      afterComment = T.unpack (snd (T.breakOnEnd end s))


removeSingleLine :: String -> String
removeSingleLine "" = ""
removeSingleLine (x:xs)
  |x == '/' && head xs == '/' = beforeComment ++ afterComment
  |otherwise = (x:xs)
    where
      s = T.pack (x:xs)
      start = T.pack "/"
      end = T.pack "\n"
      beforeComment = T.unpack (fst (T.breakOn start s))
      afterComment = T.unpack (snd (T.breakOnEnd end s))
