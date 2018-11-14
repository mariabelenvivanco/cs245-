{- Author: Richard Eisenberg, edited by <your name here>
   File: Expr.hs

   Defines a simple expression language evaluator.
-}

module Main where

-- The import statements in this file include import lists, which state
-- exactly what is imported. This can be nice documentation, so that
-- readers know what comes from where.

-- These imports you know how to deal with.
import Data.Char ( isSpace, isDigit )
import Text.Read ( readMaybe )

-- These are more advanced, used only in `main`.
import Control.Exception ( SomeException(..), evaluate, catch )
import Control.Monad     ( when )
import System.Exit       ( exitSuccess )

-- The AST type for parsed expression trees
data Expr
  = Plus Expr Expr
  | Minus Expr Expr
  | Times Expr Expr
  | Divide Expr Expr
  | Num Integer
  deriving (Eq, Show)

-- Possible tokens
data Token
  = PlusT
  | MinusT
  | TimesT
  | DivideT
  | NumT Integer
  deriving (Eq, Show)

-- Read an input string into a list of tokens.
lexTokens :: String -> [Token]
lexTokens input = lexNoPrefix (findToken input)

-- Drop any non-lexed prefix of the input. This language
-- is so simple that we can just use dropWhile.
findToken :: String -> String
findToken = dropWhile isSpace

-- Lex an input string, assuming that the first thing
-- in the string (if anything) is a token (as opposed to
-- whitespace).
lexNoPrefix :: String -> [Token]
lexNoPrefix []     = []
lexNoPrefix (c:cs) = token : lexTokens rest
  where
    (token, rest) = lex1 c cs

-- Given the first character and the rest of the input string,
-- lex one token, returning the remainder of the input string.
lex1 :: Char -> String -> (Token, String)

-- lex a number
lex1 c cs
  | isDigit c
  , (more_digs, rest) <- span isDigit cs
  , Just n <- readMaybe (c:more_digs)
  = (NumT n, rest)

-- lex the operators
lex1 '+' cs = (PlusT, cs)
lex1 '-' cs = (MinusT, cs)
lex1 '*' cs = (TimesT, cs)
lex1 '/' cs = (DivideT, cs)

-- Otherwise, we have a lexical error
lex1 c cs = error ("No lex: " ++ (c:cs))

-- Parse one expression from a list of tokens, also returning
-- the remaining, unparsed tokens.
parse1 :: [Token] -> (Expr, [Token])
parse1 = error "not implemented yet"

-- Parse a list of tokens into an expression. Errors if there are
-- too few or too many tokens.
parse :: [Token] -> Expr
parse = error "not implemented yet"

-- Evaluate an expression to a number.
eval :: Expr -> Integer
eval = error "not implemented yet"

-- Evaluate a string into a number.
evalString :: String -> Integer
evalString str = eval (parse (lexTokens str))

-- A read-eval-print loop (REPL)
-- (You are not expected to understand this.)
main :: IO ()
main = do

  -- primary user interaction commands
  putStrLn ""
  putStrLn "Enter a prefix expression:"
  expr_string <- getLine

  -- allow users to quit
  when (expr_string == "quit")
    exitSuccess

  -- This code runs evalString in a way that, if evalString calls `error`,
  -- the program will not immediately abort. The Haskell features used here
  -- are beyond the scope of CS245. The curious may enjoy looking these
  -- functions up online.
  catch (do value <- evaluate (evalString expr_string)
            print value)
        (\ (SomeException e) -> print e)

  -- And do it again.
  main
