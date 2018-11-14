{- Name: <Maria Vivanco>
 File: Asst2.hs
 Desc: CS245, Assignment 2
-}
module Asst2 where

--2.worked with Liwen
findWithDefault :: Eq a => a -> [(a,b)] -> b -> b
findWithDefault _ [] z = z
findWithDefault x (y:ys) z
 |x == fst y = snd y
 |otherwise = findWithDefault x ys z

--3.
find :: Eq a => a -> [(a,b)] -> Maybe b
find _ [] = Nothing
find x (y:ys)
  |x == fst y  = Just (snd y)
  |otherwise   = find x ys

--4. worked with Liwen
index :: Integer -> [a] -> Maybe a
index _ [] = Nothing
index x (y:ys)
  |x < 0 = Nothing
  |x > fromIntegral (length ys) = Nothing
  |otherwise = Just ((y:ys) !! fromIntegral x)

--5.
tails :: [a] -> [[a]]
tails [] = [[]]
tails (x:xs) = (x:xs) : (tails xs)

--from Asst1
divides :: Integer -> Integer -> Bool
divides y x = (x `mod` y == 0)

--6.
factorsBelow :: Integer -> Integer -> [Integer]
factorsBelow n d
  |d == 0 = []
  |d == 1 = [1]
  |divides d n == True = d : factorsBelow n (d-1)
  |otherwise = factorsBelow n (d-1)

-- 7.
factors:: Integer -> [Integer]
factors n = factorsBelow n n

--8.
digitsR :: Integer -> [Integer]
digitsR 0  = []
digitsR x =  [x `mod` 10] ++ digitsR (x `div` 10)
-- digitsR x = mod x 10 : digitsR (div n 10) - > other solution

--9.
digits  :: Integer -> [Integer]
digits x =  reverse (digitsR x)

--10.
undigitsR :: [Integer]  -> Integer
undigitsR [] = 0
undigitsR (x:xs) = undigitsR(xs) * 10 + x

--11.
undigits :: [Integer] -> Integer
undigits [] = 0
undigits x = undigitsR (reverse x) -- other solution
{-|length(x:xs)== 1 = x
  |otherwise = (x * 10^(length (x:xs)-1))  + undigits(xs)-} -- my solution

--12a.
insert :: Ord a => a -> [a] -> [a] -- Source: Hu pg 62.
insert x [] = [x]
insert x (y:ys)
  |x <= y     = x : y : ys
  |otherwise  = y : insert x ys

--12b.
insertionSort :: Ord a => [a] -> [a] -- Source Hu pg 62.
insertionSort [] = []
insertionSort (x:xs) = insert x (insertionSort xs)

--helper function
--remove :: Ord a => a -> [a] -> [a]

--13.a  -- work with Mikal
select :: Ord a => a -> [a] -> (a,[a])
select n [] = (n,[])
select n (x:xs)
  |x <= minimum (n:x:xs) = (x, n:xs)
  |otherwise = select x (xs ++ [n])

--13.b  -- worked with  Mikal
selectionSort :: Ord a => [a] -> [a]
selectionSort [] = []
selectionSort [x] = [x]
selectionSort (x:xs) = [fst (select x xs)] ++ selectionSort (snd(select x xs))

--14. a: Helper function for merge sort
merge :: Ord a => [a] ->  [a] -> [a] --  help from TA
merge [] ys = ys -- empty list with other list
merge xs [] = xs -- second list is empty
merge (x:xs) (y:ys)
  | x < y = x : merge xs (y:ys) -- x is less than y, add x to merged list
  |otherwise = y : merge (x:xs) ys -- add y to merged list


--14. b: Helper function for mergeSort
split :: [a] -> ([a], [a]) -- help from nanda
split xs  = (take divide xs, drop divide xs) -- take: shows that many elements  drop: remove those many elements
            where -- using where instead of a helper function
              divide  = length xs `div` 2 -- divide length by two

--14.
mergeSort :: Ord a => [a] -> [a]
mergeSort []  = []
mergeSort [x] = [x]
mergeSort xs = merge (mergeSort left) (mergeSort right) -- mergesort left and right sides
              where
              (left, right) = split xs

--15. QuickSort
quickSort :: Ord a => [a] -> [a] -- source : Hu pg. 65
quickSort [] = []
quickSort (x:xs) = quickSort smaller ++ [x] ++ quickSort larger -- append two lists between the median
                   where -- filter returns an array of the elements that meet the predicate
                     smaller =  filter (<x) xs -- filter the elements in xs, less than current x
                     larger  =  filter (>= x) xs -- filter the elements in xs greater than or equal to x,
                     -- do the function recurssively to each element
