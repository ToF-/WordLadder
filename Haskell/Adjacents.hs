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
ladder ws start end = ladder' ads end [start] [start] 
    where
    ads = adjacents ws
    ladder' _  _ [] _ = []
    ladder' ads end (next:ns) (vs) | next == end = [end]
                                | otherwise = case lookup next ads of
                                     Nothing -> let l = ladder' ads end ns vs++[next]
                                                in if null l then [] else [next] ++ l
                                     Just ns' -> let l = ladder' ads end (ns ++ (ns'\\(ns++vs++[next]))) (vs++[next]) 
                                                in if null l then [] else [next] ++ l
