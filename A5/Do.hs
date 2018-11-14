{- Author: Maria Vivanco
 File: Do.hs
 Practice exercises with do-notation
-}
module Main where
main :: IO ()
main = do
  putStrLn "Hello, world!"
  first <- prompt "What is your name?"
  putStrLn $ "Hello, " ++ first
  second <- prompt2 "Enter two lines of text:"
  putStrLn $ second

-- main = do
--    str1 <- prompt "Enter a number:"
--    str2 <- prompt "Enter another number:"
--    case readMaybe str1 of  -- 	convert	a	String into	some	other	type	a.
--    Nothing -> putStrLn "The first input isn't a number." -- if conversion is invalid then return nothing
--    Just n1 -> case readMaybe str2 of -- n1 is valid but now checks if str2 is valid
--    Nothing -> putStrLn "The second input isn't a number." -- n2 cannot be converted
--    Just n2 -> do
--    putStrLn "You have entered two numbers."
--    let sum = n1 + n2 -- local variable as sum
--    putStrLn $ "Your sum is " ++ show sum ++ "."


prompt :: String -> IO String -- returns monad (IO)
prompt query = do -- inside are Statements
  putStrLn query --side effect	of printing	some text in a terminal	window
  answer <- getLine -- 	answer	value	will	be	the	result	of	running	the	getLine action, type String
  pure answer -- function pure makes answer into monad type

-- 6. 
prompt2 :: String -> IO String -- concatinate two strings of input
prompt2 query = do
  str1 <- prompt query
  str2 <- getLine
  let answer = str1 ++ str2
  pure answer
