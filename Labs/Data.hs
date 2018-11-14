{- Author: Richard Eisenberg
   File: Data.hs

   Demonstrates the use of datatypes in Haskell
-}

module Data where

-- A day is one of seven possibilities:
data DayOfWeek
  = Sunday
  | Monday
  | Tuesday
  | Wednesday
  | Thursday
  | Friday
  | Saturday
  deriving (Eq, Show)
    -- This last line allows us to compare weekdays for equality (Eq)
    -- and for GHCi to print them (Show)

-- The constants Sunday, Monday, etc., are called *constructors* of DayOfWeek

-- Is this a weekday?
isWeekday :: DayOfWeek -> Bool
isWeekday Sunday   = False
isWeekday Saturday = False
isWeekday _        = True

-- What's the next day after this one?
nextDay :: DayOfWeek -> DayOfWeek
nextDay Sunday    = Monday
nextDay Monday    = Tuesday
nextDay Tuesday   = Wednesday
nextDay Wednesday = Thursday
nextDay Thursday  = Friday
nextDay Friday    = Saturday
nextDay Saturday  = Sunday

-- Datatypes can also hold data. Suppose we have homework during the week,
-- but not over weekends.

-- This makes a type synonym, saying that Homework is just a String.
type Homework = String

-- Note that the constructors' names have to be different than the names
-- above. It is common to use a suffix like we've done here.
data HWDayOfWeek
  = SundayHW
  | MondayHW Homework
  | TuesdayHW Homework
  | WednesdayHW Homework
  | ThursdayHW Homework
  | FridayHW
  | SaturdayHW
  deriving (Eq, Show)

-- extract the day's homework, if any
getHomework :: HWDayOfWeek -> Maybe Homework
getHomework (MondayHW hw)    = Just hw
getHomework (TuesdayHW hw)   = Just hw
getHomework (WednesdayHW hw) = Just hw
getHomework (ThursdayHW hw)  = Just hw
getHomework _                = Nothing

-------------------------------------------------------------

-- This type is just like the built-in list, but with different
-- names.
data List a
  = Nil
  | Cons a (List a)
  deriving (Eq, Show)

-- List is a *parameterized type*, meaning that it takes a type parameter
-- named "a". Like other type variables, this parameter can be anything.
-- In the Cons constructor, we see that a Cons holds both an "a" and a
-- list.

-- get the length of a list
myLength :: List a -> Int
myLength Nil         = 0
myLength (Cons _ xs) = 1 + myLength xs

-- convert to a normal list
toNormalList :: List a -> [a]
toNormalList Nil         = []
toNormalList (Cons x xs) = x : toNormalList xs

-- find an element
find :: Eq a => a -> List a -> Maybe Int
find _ Nil = Nothing
find x (Cons y ys)
  | x == y              = Just 0
  | Just n <- find x ys = Just (n+1)
  | otherwise           = Nothing

{- The following types are defined in the Haskell Prelude, which is
automatically imported into every module.

data Bool
  = False
  | True

data Maybe a
  = Nothing
  | Just a

data [a]
  = []
  | a : [a]
-}

----------------------------------------------------------
-- Here is a definition of a binary search tree:

data BST a
  = Leaf
  | Node (BST a)   -- left child
         a         -- data
         (BST a)   -- right child
  deriving Show
    -- We don't derive Eq, because two trees are the same
    -- as long as the hold the same data, even if they are
    -- structurally distinct

-- insert into a tree
insert :: Ord a => a -> BST a -> BST a
insert x Leaf = Node Leaf x Leaf
insert x (Node left dat right)
  | x <= dat  = Node (insert x left) dat right
  | otherwise = Node left dat (insert x right)

-- check if an element is in a tree
elemBST :: Ord a => a -> BST a -> Bool
elemBST _ Leaf = False
elemBST x (Node left dat right)
  | x == dat  = True
  | x < dat   = elemBST x left
  | otherwise = elemBST x right

-- make a tree from the elements in a list
insertAll :: Ord a => [a] -> BST a
insertAll []     = Leaf
insertAll (x:xs) = insert x (insertAll xs)

-- some QuickCheck properties that should hold of all trees

-- inserting an element means it's in the tree
prop_insertAll :: Int -> [Int] -> Bool
prop_insertAll = \x xs -> elemBST x (insert x (insertAll xs))

-- If x isn't in xs, then it's not in the tree.
prop_notInTree :: Int -> [Int] -> Bool
prop_notInTree = \x xs -> (x `elem` xs) || (not (x `elemBST` insertAll xs))
