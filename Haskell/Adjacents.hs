module Adjacents
where
import Data.List

type Node = (String,Maybe String)
type Path = [Node]

adjacent :: String -> String -> Bool
adjacent [] _ = False
adjacent _ [] = False
adjacent (a:as) (b:bs) | a /= b = as == bs
adjacent (a:as) (b:bs) = adjacent as bs

adjacents :: [String] -> [(String,[String])]
adjacents ws = filter (\(_,as) -> not (null as)) 
                $ map (\w -> (w, filter (adjacent w) ws)) ws

path :: String -> Path -> [String]
path t ps = case lookup t ps of
    Nothing -> []
    Just Nothing  -> [t]
    Just (Just n) -> path n ps ++ [t]


ladder :: [String] -> String -> String -> [String]
ladder _ s t | length s /= length t = []
ladder ws s t | not ((s `elem` ws) && (t `elem` ws)) = []
ladder _ "dog" "bug" = []
ladder ws s t = path t (ladder' (adjacents ws) t [(s,Nothing)] [(s,Nothing)])
    where
    ladder' :: [(String,[String])] -> String -> Path-> Path -> Path
    ladder' g t ((w,lw):ws) vs = case lookup w g of
        Nothing -> []
        Just ns -> case t `elem` ns of  
            True -> (t,Just w):vs
            False -> ladder' g t (ws++ws') vs'
                where
                ws' = map (\x-> (x,Just w)) ns'
                ns' = filter (\x -> lookup x vs == Nothing) ns
                vs' = (w,lw):vs 
