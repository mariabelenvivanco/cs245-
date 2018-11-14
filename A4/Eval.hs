{- Author: Richard Eisenberg
   File: Eval.hs

   Defines an evaluator for Preλ
-}

module Eval where

import Syntax

-- Evaluate an expression to a value. Calls `error` if
-- this is impossible.
-- TODO : App eval

eval :: Expr -> Value
eval (ValueE(b)) = b
eval (OpE (op) (ValueE(IntegerV a)) (ValueE(IntegerV b))) = performOp op a b
-- recurrsively for operator -
eval (IfE (ValueE(BoolV condition))(ifBody) (elseBody)) = performIf (condition) (ifBody) (elseBody)
eval (NotE (ValueE (BoolV b))) = performNot b

eval expr = error "not able to evaluate"

performNot :: Bool -> Value
performNot expr
  |expr == True = BoolV(False)
  |otherwise = BoolV(True)


performIf :: Bool -> Expr -> Expr -> Value
performIf condition ifBody elseBody
  |condition == True = eval ifBody
  |otherwise =  eval elseBody

-- All binary operators take two Integer arguments. This
-- function performs the operation on the arguments, returning
-- a Value.
-- performIf :: Expr -> Expr ->
performOp :: Op -> Integer -> Integer -> Value
performOp Plus integer integer2 = IntegerV (integer + integer2)
performOp Minus integer integer2 = IntegerV (integer - integer2)
performOp Times integer integer2 = IntegerV (integer * integer2)
performOp LessThan integer integer2 = BoolV (integer < integer2)
performOp LessThanEquals integer integer2 = BoolV (integer <= integer2)
performOp GreaterThan integer integer2 = BoolV (integer > integer2)
performOp GreaterThanEquals integer integer2 = BoolV (integer >= integer2)
performOp Equals integer integer2 = BoolV (integer == integer2)
performOp NotEquals integer integer2 = BoolV (integer /= integer2)

-- Substitute a value into an expresmsion
-- If you want (expr)[x := val], call (subst expr "x" val)
-- subst :: Expr -> String -> Value -> Expr
-- -- Substitute instances of string w value in expr
-- -- subst expr str value
-- --   where VarE is in expr -> put value in exp
