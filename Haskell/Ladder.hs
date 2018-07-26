module Ladder where

type Graph = [(String,[String])]
type Queue = [Edge]
type Edge = (String,String)

graph :: [String] -> Graph
graph ws = map (\w -> (w,[ n | n <- ws, n `adjacent` w])) ws   
    where
    "" `adjacent` "" = False
    (c:cs) `adjacent` (d:ds) | c == d = cs `adjacent` ds
                             | otherwise = cs == ds 

insert :: Edge -> Queue -> Queue
insert (a,b) s | (lookup a s) == Nothing = s ++ [(a,b)]
               | otherwise      = s

union :: Queue -> Queue -> Queue
union s t = foldl (\set e -> insert e set) s t

