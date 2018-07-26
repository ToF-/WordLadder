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
union = foldl (\set e -> insert e set) 

minus :: Queue -> Queue -> Queue
minus q r = [(w,p) | (w,p) <- q, lookup w r == Nothing]

path :: Queue -> String -> String -> [String]
path q s t | s == t = [s]
           | otherwise = case lookup t q of
                Just p -> path q s p ++ [t]

search :: Graph -> Queue -> Queue -> Queue
search g [] done = done
search g (edge:edges) done = search g (edges++(adjacents edge `minus` edges `minus` done)) (edge:done)
    where 
    adjacents :: Edge -> Queue
    adjacents (w,_) = case lookup w g of
        Nothing -> []
        Just as -> map (\a -> (a,w)) as
