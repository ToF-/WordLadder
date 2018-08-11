module Ladder
where 
import Prelude hiding (Word)

type Word = String 
type Step = (Word, Word)
type Paths = [Step]

adjacent :: Word -> Word -> Bool
adjacent [] [] = False
adjacent (c:cs) (d:ds) | c /= d = cs == ds
                       | otherwise = adjacent cs ds

adjacents :: [Word] -> Word -> [Word]
adjacents words word = filter (adjacent word) words

add :: Step -> Paths -> Paths
add step@(word,next) steps = case lookup word steps of
    Just already -> steps
    Nothing -> steps ++ [step]

path :: Word -> Paths -> [Word]
path word steps = case lookup word steps of
    Nothing -> []
    Just next -> word : path next steps 

search :: [Word] -> Word -> Word -> Paths
search words target origin = breadth_search [(target,"")] []
    where 
    breadth_search :: [Step] -> Paths -> Paths
    breadth_search [] _ = []
    breadth_search (step@(word,_):to_visit) paths | word == origin = step : paths
    breadth_search (step@(word,_):to_visit) paths = breadth_search to_visit' paths'
        where 
        to_visit' = foldl (flip add) to_visit neighbors
        neighbors  = map (link_to word) $ filter is_new $ adjacents words word
        link_to = flip (,)
        is_new s = lookup s paths' == Nothing
        paths' = step:paths

ladder :: [Word] -> Word -> Word -> [Word]
ladder words origin target = path origin  $ search words target origin

ladderFromFile :: String -> Word -> Word -> IO [Word]
ladderFromFile file_name origin target = fmap process $ readFile file_name
    where 
    process :: String -> [Word]
    process file_contents = ladder ((filter (same length origin)) (lines file_contents)) origin target
    same f a b = f a == f b
