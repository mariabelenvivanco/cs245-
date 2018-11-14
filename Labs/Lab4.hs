{-Maria Vivanco
-Lab 4
10/3/2018-}

data Month
  = Jan
  | Feb
  | Mar
  | Apr
  | May
  | Jun
  | Jul
  | Aug
  | Sep
  | Oct
  | Nov
  | Dec
  deriving (Eq, Show)

has30days :: Month -> Bool --returns true if the month has 30 days
has30days Apr = True
has30days Jun = True
has30days Sep = True
has30days _ = False
