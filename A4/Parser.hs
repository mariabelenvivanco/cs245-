{- Author: <your name here>
   File: Parser.hs

   Parses the Preλ syntax
-}

{-- Part 3. Textual Drawings
a. + - 5 4 3
        +
      /  \
    -     3
  /   \
5      4
Part 4: Haskell Representation: OpE(Plus (Minus ValueE(IntegerV 5) ValueE(IntegerV 4)) ValueE(IntegerV 3))
Part 5: Tokens lexed: [OpT Plus, OpT Minus, LiteralT IntegerV 5, LiteralT IntegerV 4, LiteralT IntegerV 3]

b. if < 5 3 then true else * 9 3
                        if
  (condition)  /          \                \ (else-body)
              <            true            *
            /  \                          / \
            5     3                      9   3
Part 4: Haskell Representation: IfE(OpE (LessThan ValueE(IntegerV 5) ValueE(IntegerV 3)))ValueE(BoolV True)) OpE(Times ValueE(IntegerV 9) ValueE(IntegerV 3))
Part 5: Tokens Lexed: [IfT, OpT LessThan, LiteralT IntegerV 5, LiteralT Integer V 3, ThenT, LiteralT BoolV True, ElseT, OpT Times, LiteralT IntegerV 9, LiteralT IntegerV 3]


c. + 5 -- OpE requires two expressions
    +
  /
5

d. @ \ x . + x 3 5

                  @
            /         \
          \            5
        /   \
      x      +
            /  \
          x     3
Haskell Representation: AppE(ValueE(LambdaV "x" OpE (Plus VarE "x" ValueE IntegerV 3)))(ValueE IntegerV 5)
Tokens Lexed: [AppT,LambdaT, VarT "x",DotT, Op Plus, VarT " x", LiteralT 3, LiteralT 5]
-}

module Parser where

import Token
import Syntax
import Data.List

-- Parse an expression, returning the parsed expression
-- and a list of unconsumed tokens
-- Calls `error` if the list of tokens has no valid parse.
parse :: [Token] -> (Expr, [Token]) -- expr.hs given
parse (LiteralT(n): rest) -- value: integer V/bool (literal) Lambda
  = (ValueE(n), rest)
-- parse (LambdaT : rest) --TODO: Lambda
--    = (ValueE(LambdaV str arg2),rest2)
--      where
--       (arg1,rest1) = parse rest
--       str = if checkVar arg1 == True =   -- get string from arg1
--       (arg2,rest2) = parse rest1 -- expr


parse (VarT(n): vRest) -- variable expression
  = (VarE n,vRest)

parse (OpT(op) : rest1) = (OpE op arg1 arg2, rest3) -- operator expression
  where
    (arg1, rest2) = parse rest1
    (arg2, rest3) = parse rest2

parse (AppT : rest1)
  | (arg1, rest2) <- parse rest1
  , (arg2, rest3) <- parse rest2
  = (AppE arg1 arg2,rest3)

parse (NotT : rest) -- not expression
  | (arg1, rest2) <- parse rest
  = (NotE arg1, rest2)

parse (IfT : rest1) = (IfE arg1 arg2 arg3, rest4)  -- operator expression
  where
    (arg1,(x:xs)) = parse rest1 -- arg1 - condition
    rest2 = if (checkThen x == True)
            then xs
            else error ("invalid if statement")
    (arg2, (y:ys)) =  parse rest2 -- arg1 then body
    rest3 = if (checkElse y == True)
            then ys
            else error ("invalid if statement")
    (arg3, rest4) =  parse rest3 -- else body

parse tokens = error ("invalid parse")
checkElse :: Token -> Bool
checkElse ElseT = True
checkElse _ = False

checkThen :: Token -> Bool
checkThen ThenT = True
checkThen _ = False

checkVar :: Token -> Bool
checkVar (VarT a) = True
checkVar _ = False

mkOp :: Token -> Expr -> Expr -> Expr -- expr.hs given
mkOp (OpT Plus)  arg1 arg2 = OpE Plus arg1 arg2
mkOp (OpT Minus) arg1 arg2 = OpE Minus arg1 arg2
mkOp (OpT Times) arg1 arg2 = OpE Times arg1 arg2
mkOp (OpT Divides) arg1 arg2 = OpE Divides arg1 arg2
