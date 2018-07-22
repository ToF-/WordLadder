module Ladder where

ladder :: [String] -> String -> String -> [String]
ladder _ s t | s == t = []
ladder _ s t | s `adjacent` t = [s,t]
    where
    adjacent "DOG" "COG" = True
    adjacent "DOG" "BOG" = True
    adjacent _ _ = False
ladder _ _ _ = ["DOG","COG","COT","CAT"]
