import Data.List

ws = words "BAG BOG BAT BUG CAT COG COT DOG FOG FIG FAT FOO QUX"

graph ws = map (\w -> (w,filter (w `adjacent`) ws)) ws
    where
    adjacent [] [] = False
    adjacent (c:cs) (d:ds) | c /= d = cs == ds
                           | otherwise = adjacent cs ds

edges :: (String,[String]) -> [(String,String)]
edges (w,ns) = map (\n -> (w,n)) ns

pretty :: (String,String) -> String
pretty (s,t) = show s ++ " -- " ++ show t ++ "[dir=none] ;"

strict :: [(String, String)] -> [(String, String)]
strict = filter (\(x,y) -> x < y)

process = unlines . map pretty . strict . concatMap edges . map (fmap sort) . graph

main = do
    putStrLn "strict graph example {"
    putStrLn $ process ws
    putStrLn "}"
