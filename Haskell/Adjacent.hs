import System.Environment

main :: IO ()
main = do
    args <- getArgs
    process args

process :: [String] -> IO () 
process ss | length ss < 2 = putStrLn "usage: Adjacent <size> <word-file>"
process [size,file] = do
    words <- fmap (filter (\w -> length w == n)) $ fmap words $ readFile file
    print $ adjacents words
    where 
    n = read size
    adjacent :: String -> String -> Bool
    adjacent [] [] = False
    adjacent (a:as) (b:bs) | a /= b    = as == bs
                           | otherwise = adjacent as bs 

    adjacents :: [String] -> [(String,[String])]
    adjacents ws = filter (\(_,as) -> not (null as)) $ map (\w -> (w, filter (adjacent w) ws)) ws
  
    
 
