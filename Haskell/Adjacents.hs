module Adjacents
where
import Data.List as L (filter, null, map, foldr, reverse, dropWhile, sortBy, nub)
import Data.Map as M (fromList, lookup, Map)
import Data.Set as S (member, Set, insert, empty)
import Data.Ord (comparing)

type Graph = M.Map String [String]
type Path  = [String]


adjacent :: String -> String -> Bool
adjacent [] _ = False
adjacent _ [] = False
adjacent (a:as) (b:bs) | a /= b = as == bs
adjacent (a:as) (b:bs) = adjacent as bs

adjacents :: [String] -> Graph
adjacents ws = fromList $ map (\w -> (w, L.filter (adjacent w) ws)) ws


ladders :: Graph -> String -> String -> [Path]
ladders g s t = 
    nub (sortBy (comparing length) (map reverse (([[s]] >>= (search g (insert s empty) t)))))

search :: Graph -> Set String -> String -> Path -> [Path]
search g vs t (x:xs) | t == x = [(x:xs)] 
                     | otherwise = case neighbors of 
    [] -> [(x:xs)]
    ns -> (map (\n-> (n:x:xs)) ns) >>= (search g (L.foldr insert vs ns) t) 
    where
    neighbors = case M.lookup x g of
        Nothing -> []
        Just ns -> filter (\n -> not (member n vs)) ns

ladder :: [String] -> String -> String -> [String] 
ladder ws s t = reverse (
        head (
            sortBy (comparing length) (
                    filter (elem t) (
                        [[s]] >>= (search (adjacents ws) (insert s empty) t)
                        )
               )
            )
        )
