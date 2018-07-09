module Adjacents
where
import Data.List as L
import Data.Map as M
import Data.Set as S

type Graph = M.Map String [String]
type Path  = [String]


adjacent :: String -> String -> Bool
adjacent [] _ = False
adjacent _ [] = False
adjacent (a:as) (b:bs) | a /= b = as == bs
adjacent (a:as) (b:bs) = adjacent as bs

adjacents :: [String] -> Graph
adjacents ws = M.fromList $ L.filter (\(_,as) -> not (L.null as)) 
                $ L.map (\w -> (w, L.filter (adjacent w) ws)) ws


ladders :: Graph -> String -> [Path] -> Set String -> [Path]
ladders g t ps vs = L.filter (elem t) $ ps >>= search 
    where 
    search (x:xs) = L.map (\n-> (n:x:xs)) $  L.filter (\n -> not (S.member n vs)) (neighbors x g)

    neighbors x g = case M.lookup x g of
        Nothing -> []
        Just ns -> ns
