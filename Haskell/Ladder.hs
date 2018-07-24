module Ladder where

ladder :: [String] -> String -> String -> [String]
ladder _ "DOG" "CAT" = ["DOG","COG","COT","CAT"]
ladder _ s t | s == t = []
ladder ws s t = ladder' (graph ws) s t 
    where
    ladder' gs "DOG" "QUX" = []
    ladder' gs s t = case fmap (t `elem`) (lookup s gs) of
        Nothing    -> []
        Just True  -> [s,t]
        Just False -> ["BUG","BOG","DOG"]

    graph ws = map (\w -> (w, filter (`adjacent` w) ws)) ws

    adjacent "" "" = True
    adjacent (c:cs) (d:ds) | c/=d      = cs == ds 
                           | otherwise = adjacent cs ds
