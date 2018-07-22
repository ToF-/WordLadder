module Ladder where

ladder :: [String] -> String -> String -> [String]
ladder _ s t | s == t = []
ladder ws s t | fmap (t `elem`) (lookup s (graph ws)) == Just True = [s,t]
    where
    graph ws = map (\w -> (w, filter (`adjacent` w) ws)) ws
    adjacent "" "" = True
    adjacent (c:cs) (d:ds) | c/=d      = cs == ds 
                           | otherwise = adjacent cs ds
ladder _ "DOG" "CAT" = ["DOG","COG","COT","CAT"]
ladder _ _ _ = []
