{- Name: <your
name here>
File: Asst1.hs
Desc: CS245, Assignment 1

Setup: using lab computer and using atom editor
-}
module Asst1 where
doNothing x = x

-- 3. add1
add1 :: Float -> Float
add1 x = x + 1

--4. always0
always0 :: Integer -> Integer
always0 x = 0

--5.sub
sub :: Integer -> Integer -> Integer
sub x y = x - y

-- 6. addmult
addmult :: Integer -> Integer -> Integer -> Integer
addmult p q r = (p + q) * r

--9. myAbs
myAbs :: Integer -> Integer
myAbs n
  |n >= 0 = n
  |otherwise = 0 - n

--10. pushOut
pushOut :: Integer -> Integer
pushOut n
  |n == 0 = 0
  |n > 0 = n + 1
  |otherwise = n - 1

-- 11. greet
greet :: String -> String
greet n =  "Hi " ++ n

-- 12. greet2
greet2 :: String -> String
greet2 n
  |null n = "Hi there"
  |otherwise = greet n

makeAs 0 = ""
makeAs n = "a" ++ makeAs (n-1)
{- 13.
  makeAs 3 = "a" ++ makeAs (2) => "a" ++ "aa" -> "aaa"
  makeAs 2 = "a" ++ makeAs(1) => "a" ++ "a" -> "aa"
  makeAs 1 = "a" ++ makeAs (0) => "a"
  makeAs 0 = ""
-}
-- 14. twiceAs
twiceAs :: Integer -> String
twiceAs 0 = ""
twiceAs n = "aa" ++ twiceAs (n-1)

--15. countDown
countDown :: Integer -> String
countDown n
  |n <= 0 = "Too Low"
countDown 1 = "1 "
countDown n = show n ++ " " ++ countDown(n-1)

-- 16. countUp
--Elizabeth collaborated w/ me
countUp :: Integer -> String
countUp 0 = ""
countUp n
  |n > 0 = countUp(n-1) ++ " " ++ show n
  |n < 0 = show n ++ " " ++ countUp(n+1)

--17. triangle
-- Elizabeth collaborated w/ me
triangle :: Integer -> Integer
triangle 0 = 0
triangle n
 |n > 0 = n + triangle(n-1)
 |otherwise =  0 - (-n + triangle(-n-1))

--18. divides
divides :: Integer -> Integer -> Bool
divides y x = (x `mod` y == 0)

--19. hasNoDivisorsLessThan
-- worked with Nanda
hasNoDivisorsLessThan :: Integer -> Integer -> Bool
hasNoDivisorsLessThan n d
  |d <= 2 = True
  |divides (d-1) n == True = False
  |otherwise =  hasNoDivisorsLessThan n (d-1)

-- 20. isPrime
isPrime :: Integer -> Bool
isPrime n
  |n <= 0 = False
  |otherwise = hasNoDivisorsLessThan n n
