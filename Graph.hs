import Data.List

ws = words "BAG BAT BUG CAT COG COT DOG DAG FOG FIG FAT FOO QUX"

gs = map (\w -> (w,filter (w `adjacent`) ws)) ws
    where
    adjacent [] [] = False
    adjacent (c:cs) (d:ds) | c /= d = cs == ds
                           | otherwise = adjacent cs ds

pp :: (String,[String]) -> String
pp (w,ns) = unlines (map (pw w) ns)
    where
    pw :: String -> String -> String
    pw s t = show s ++ " -> " ++ show t ++ "[dir=none] ;"

ss = sort (map (fmap sort) gs)
main = do
    putStrLn "digraph example {"
    putStrLn $ unlines $ map pp ss
    putStrLn "}"
