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
    Nothing -> steps ++ [step]
    Just _ -> steps

path :: Word -> Paths -> [Word]
path word words = case lookup word words of
    Nothing -> []
    Just next -> word : path next words 

search :: [Word] -> Word -> Word -> Paths
search words target origin = search' [(target,"")] []
    where 
    search' :: [Step] -> Paths -> Paths
    search' [] _ = []
    search' (step@(word,next):toVisit) result | word == origin = step : result
    search' (step@(word,next):toVisit) result = search' toVisit' result'
        where 
        toVisit' = foldl (flip add) toVisit (map (\neighbor ->(neighbor,word)) neighbors)
        neighbors  = filter (\s -> lookup s result' == Nothing) (adjacents words word)
        result' = step:result

ladder :: [Word] -> Word -> Word -> [Word]
ladder words o t = path o (search words t o)

ladderFromFile :: String -> Word -> Word -> IO [Word]
ladderFromFile f o t = fmap process (readFile f)
    where 
    process :: Word -> [Word]
    process s = ladder (filter (\w -> length w == length o) (lines s)) o t
