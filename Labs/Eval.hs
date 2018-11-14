{- Author: Richard Eisenberg
   File: Eval.hs

   Defines an evaluator for Preλ
-}

module Eval where

import Syntax

-- Evaluate an expression to a value. Calls `error` if
-- this is impossible.
eval :: Expr -> Value
eval = error "unimplemented"

-- All binary operators take two Integer arguments. This
-- function performs the operation on the arguments, returning
-- a Value.
performOp :: Op -> Integer -> Integer -> Value
performOp = error "unimplemented"

-- Substitute a value into an expression
-- If you want (expr)[x := val], call (subst expr "x" val)
subst :: Expr -> String -> Value -> Expr
subst = error "unimplemented"
