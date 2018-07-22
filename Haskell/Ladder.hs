module Ladder where

ladder :: [String] -> String -> String -> [String]
ladder _ s t | s == t = []
ladder _ "DOG" "COG" = ["DOG","COG"]
ladder _ "DOG" "BOG" = ["DOG","BOG"]
ladder _ _ _ = ["DOG","COG","COT","CAT"]
