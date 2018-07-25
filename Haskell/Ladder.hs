module Ladder where

type Graph = [(String,[String])]

graph :: [String] -> Graph
graph ws = map (\w -> (w,[ n | n <- ws, n `adjacent` w])) ws   
    where
    "" `adjacent` "" = False
    (c:cs) `adjacent` (d:ds) | c == d = cs `adjacent` ds
                             | otherwise = cs == ds 

