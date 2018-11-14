
module Study  where

{-merge :: Ord a => [a] ->  [a] -> [a]
merge [] [] = [] --empty list
merge xs [] = xs  -- right list is empty
merge [] ys = ys  -- left list is empty
merge (x:xs) (y:ys) -- there are two lists
  |x >= y = x : merge  y ys
  |otherwise = y : merge x xs-}

split :: [a] -> ([a], [a])
split [] = ([],[])
split [x] = ([x],[])
split (x:xs) =  (take number xs , drop (length xs - number) xs)
                where
                  number = (2 `mod` length xs)

{-mergeSort :: Ord a => [a] -> [a]
mergeSort [] = [] -- base case : array is empty
mergeSort [x] = [x] -- base case: one element
mergeSort (x:xs) = merge (mergeSort left, mergeSort right)
                   where
                    (left, right) = split xs-}
