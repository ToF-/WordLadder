module Adjacents
where
import Data.List

type Node = (String,(Int, Maybe String))
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
    Just (0,Nothing)  -> [t]
    Just (l,(Just n)) -> path n ps ++ [t]


ladder :: [String] -> String -> String -> [String]
ladder _ s t | s == t = []
ladder _ s t | length s /= length t = []
ladder ws s t | not ((s `elem` ws) && (t `elem` ws)) = []
ladder _ "dog" "bug" = []
ladder ws s t = path t (sort (ladder' (adjacents ws) [(s,(0,Nothing))] []))

ladder' :: [(String,[String])] -> Path-> Path -> Path
ladder' _  [] vs = vs
ladder' g ((w,(l,lw)):ws) vs = case lookup w g of
    Nothing -> []
    Just ns -> ladder' g (ws++ws') vs'
            where
            ws' = map (\x-> (x,(l+1,Just w))) ns'
            ns' = filter (\x -> lookup x vs == Nothing) ns
            vs' = (w,(l,lw)):vs 
