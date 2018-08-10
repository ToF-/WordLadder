module Ladder
where 

adjacent [] [] = False
adjacent (c:cs) (d:ds) | c /= d = cs == ds
                       | otherwise = adjacent cs ds

adjacents ws w = filter (adjacent w) ws

add (k,v) ps = case lookup k ps of
    Nothing -> ps ++ [(k,v)]
    Just _ -> ps

path w ws = case lookup w ws of
    Nothing -> []
    Just n -> w : path n ws 

search :: [String] -> String -> String -> [(String, String)]
search ws t o = search' [(t,"")] []
    where 
    search' [] _ = []
    search' ((k,v):vs) rs | k == o = ((k,v):rs)
    search' ((k,v):vs) rs = search' vs' rs'
        where 
        vs' = foldl (flip add) vs (map (\n->(n,k)) ns)
        ns  = filter (\w -> lookup w rs' == Nothing) (adjacents ws k)
        rs' = (k,v):rs

ladder :: [String] -> String -> String -> [String]
ladder ws o t = path o (search ws t o)
