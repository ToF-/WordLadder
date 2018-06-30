module Adjacents
where
import Data.List

adjacent :: String -> String -> Bool
adjacent [] _ = False
adjacent _ [] = False
adjacent (a:as) (b:bs) | a /= b = as == bs
adjacent (a:as) (b:bs) = adjacent as bs

adjacents :: [String] -> [(String,[String])]
adjacents ws = filter (\(_,as) -> not (null as)) 
                $ map (\w -> (w, filter (adjacent w) ws)) ws

ladder :: [String] -> String -> String -> [String]
ladder ws start target = ladder' ads target [start] [start] 
    where
    ads = adjacents ws

    ladder' :: [(String,[String])] -> String -> [String] -> [String] -> [String]
    ladder' _  _ [] _ = []
    ladder' ads t (w:ws) (v:vs) | w == t = [v,w]
    ladder' ads t (w:ws) (v:vs) = 
        
