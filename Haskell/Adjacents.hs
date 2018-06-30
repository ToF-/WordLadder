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

path :: String -> [(String, Maybe String)] -> [String]
path t ps = case lookup t ps of
    Nothing -> []
    Just Nothing  -> [t]
    Just (Just n) -> path n ps ++ [t]

ladder :: [String] -> String -> String -> [String]
ladder ws start end = path end (ladder' (adjacents ws) end [(start,Nothing)] []) 
    where
    ladder' :: [(String,[String])] -> String -> [(String,Maybe String)] -> [(String, Maybe String)] -> [(String, Maybe String)]
    ladder' adjs end (w:ws) vs | fst w == end = (w:vs)
    ladder' adjs end (w:ws) vs = case lookup (fst w) adjs of
        Nothing -> ladder' adjs end ws (w:vs)
        Just ns -> ladder' adjs end (ws ++ ws') (w:vs) 
            where
            ws' = map (\n -> (n, Just (fst w))) ns'
            ns' = filter (\n-> lookup n vs == Nothing)  ns

