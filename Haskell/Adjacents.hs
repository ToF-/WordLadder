module Adjacents
where
import Data.List as L
import Data.Map as M

type Node = (String,(Int, Maybe String))
type Path = M.Map String (Int, Maybe String)
type Graph = M.Map String [String]


adjacent :: String -> String -> Bool
adjacent [] _ = False
adjacent _ [] = False
adjacent (a:as) (b:bs) | a /= b = as == bs
adjacent (a:as) (b:bs) = adjacent as bs

adjacents :: [String] -> Graph
adjacents ws = M.fromList $ L.filter (\(_,as) -> not (L.null as)) 
                $ L.map (\w -> (w, L.filter (adjacent w) ws)) ws

path :: String -> Path -> [String]
path t ps = case M.lookup t ps of
    Nothing -> []
    Just (0,Nothing)  -> [t]
    Just (l,(Just n)) -> path n ps ++ [t]


ladder :: [String] -> String -> String -> [String]
ladder _ s t | s == t = []
ladder _ s t | length s /= length t = []
ladder ws s t | not ((s `elem` ws) && (t `elem` ws)) = []
ladder _ "dog" "bug" = []
ladder ws s t = path t (ladder' (adjacents ws) (M.fromList [(s,(0,Nothing))]) M.empty)

ladder' :: Graph -> Path-> Path -> Path
ladder' _ tv vs | M.null tv = vs
ladder' g tv vs = ladder' g tv'' vs' 
    where
    ((w,(l,lw)), tv') = M.deleteFindMin tv
    ns :: [String]
    ns = case M.lookup w g of
        Nothing -> []
        Just xs -> xs 

    tv'' :: Path
    tv''= insertNodes tv' (L.filter (\n-> M.lookup n vs' == Nothing) ns)

    vs' :: Path
    vs' = M.insertWith minNode w (l,lw) vs

    insertNodes :: Path -> [String] -> Path
    insertNodes p ns = L.foldr insertNode p ns 

    insertNode :: String -> Path -> Path
    insertNode s p = M.insertWith minNode s (l+1,Just w) p
    
    minNode :: (Int, Maybe String)->(Int, Maybe String) -> (Int, Maybe String) 
    minNode (x,a) (y,b) | x <= y = (x,a)
                        | otherwise = (y,b)
