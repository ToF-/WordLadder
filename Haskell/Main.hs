import System.Environment
import Ladder

main :: IO ()
main = do
    args <- getArgs
    process args

process :: [String] -> IO () 
process ss | length ss < 3 = putStrLn "usage: Ladder <word-file> <start> <end>"
process [file,start,end] = do
    
    words <- fmap (filter (\w -> length w == length start)) $ fmap words $ readFile file
    putStrLn $ unwords $ ladder words start end
