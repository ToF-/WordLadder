module Ladder
where 

adjacent [] [] = False
adjacent (c:cs) (d:ds) | c /= d = cs == ds
                       | otherwise = adjacent cs ds

adjacents ws w = filter (adjacent w) ws

add (k,v) ps = case lookup k ps of
    Nothing -> ps ++ [(k,v)]
    Just _ -> ps
