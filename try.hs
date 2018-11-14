isOperator :: Char -> Bool
isOperator x = x `elem` b
  where
    b= ['=', '>', '<' ,  '!' , '~' ,'?', ':' , '+' , '-' , '*', '/' ,'&' ,'|' ,'^' ,'%']
