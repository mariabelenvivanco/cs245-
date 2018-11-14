{- Author: <Maria Vivanco>
   File: Lexer.hs

   Lexes the syntax for the Preλ interpreter
-}

{-Part 2: Lexemes
  a. if < 2 1 then true else false -> [if,<,2,1,then,else,false]
  b. hello { there } people -> [hello, people]
  c. (+12h) -> [+,12,h]
  d. iff thenn ->  [iff, thenn]
  e. tok33<= -> [tok,33,<=]
  -}
module Lexer where

import Data.Char
import Text.Read
import qualified Data.Text as T

import Token
import Syntax

-- Lex a Preλ expression into a list of tokens
-- Calls `error` if there is a lexical error (something that
-- doesn't lex)

lexPreL :: String -> [Token]
lexPreL input = lexNoPrefix  (findToken input)

lexNoPrefix :: String -> [Token]
lexNoPrefix []     = []
lexNoPrefix (c:cs) = token : lexPreL rest
  where
    (token, rest) = lex1 c cs

-- delete any non-lexed prefix
-- Ignored:(,),Comment{},Whitespace
findToken :: String -> String
findToken string = deleteParentheses(removeComment(noSpace))
  where
    noSpace = dropWhile isSpace string

deleteParentheses :: String -> String -- returns string without parentheses
deleteParentheses [] = []
deleteParentheses (x:xs)
  |(x /= '(' && x /= ')') = x : deleteParentheses xs
  |otherwise = deleteParentheses xs

removeComment :: String -> String -- returns string with no comment
removeComment "" = ""
removeComment (x:xs)
  |x == '{'  = beforeComment ++ afterComment
  |otherwise = (x:xs)
    where
      s = T.pack (x:xs)
      start = T.pack "{"
      end = T.pack "}"
      beforeComment = T.unpack (fst (T.breakOn start s))
      afterComment = T.unpack (snd (T.breakOnEnd end s))

lex1 :: Char -> String -> (Token, String) -- takes longest token
-- **  OPERATORS ** --
-- operators: + - * / < <= > >= = /=
lex1 '+' cs = (OpT Plus, cs)
lex1 '-' cs  = (OpT Minus, cs)
lex1 '*' cs = (OpT Times, cs)
lex1 '=' cs = (OpT Equals,cs)

lex1 '/' cs
  |cs == [] = (OpT Divides, "")
  |head cs == '=' = (OpT NotEquals,tail cs)
  |otherwise = (OpT Divides,cs)

lex1 '<' cs
  |cs == [] = (OpT LessThan, "")
  |head cs == '=' = (OpT LessThanEquals, tail cs)
  |otherwise = (OpT LessThan, cs)

lex1 '>' cs
  |cs == [] = (OpT GreaterThan, "")
  |head cs == '=' = (OpT GreaterThanEquals, tail cs)
  |otherwise = (OpT GreaterThanEquals, cs)
-- **  KEYWORDS ** --
lex1 '@' cs  = (AppT,cs)
lex1 '\\' cs = (LambdaT,cs)
lex1 '.' cs = (DotT,cs)


lex1 c cs -- Token, String
  --isAlpha: ifT, ThenT, Else, VarT String, LiteralT Bool
  |isAlpha c = (token, rest)
  |isDigit c
    , (more_digs, rest) <- span isDigit cs
    , Just n <- readMaybe (c:more_digs)
    = (LiteralT (IntegerV n), rest)
  |otherwise = error ("No lex: " ++ (c:cs))
    where
      token = checkStringTokenType (c:cs)
      rest = snd (idenToken (c:cs))

      ---token = checkKeyWord check


idenToken :: String -> (String, String) -- returns tuple of identifer token and rest of array
idenToken [] = ([],[])
idenToken str
  | isLetter (head str) = ([head str] ++ x , y) --  y is rest of string, x is the built string of the identifer token
  | otherwise = ("",str)
  where
    (x,y) = idenToken (tail str)

checkStringTokenType :: String -> Token
checkStringTokenType str
  |identifer == "if" = IfT
  |identifer == "then" = ThenT
  |identifer == "else" = ElseT
  |identifer == "not" = NotT
  |identifer == "true" = LiteralT (BoolV True)
  |identifer == "false" = LiteralT (BoolV True)
  |otherwise = VarT identifer
    where
      identifer = fst (idenToken str)
-- checkKeyWord c:cs
--   |
--
--     where
--       (identifer,rest) = idenToken (c:cs)
--       string = fst
