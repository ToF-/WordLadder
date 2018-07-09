import Test.Hspec
import Adjacents
import Data.List
import Data.Map as M (toList,fromList)
import Data.Set as S

ws = sort $ words "do dog fog fig fit fat cat cog cot bug bog bag bat"
sp = words "dog cog cot cat"
main = hspec $ do

    describe "adjacent" $ do
        it "is false if words are identical" $ do
            adjacent "foo" "foo"  `shouldBe` False

        it "is false if words differ by size" $ do
            adjacent "foo" "to" `shouldBe` False

        it "is true if words differ by one letter" $ do
            adjacent "foo" "too" `shouldBe` True
            adjacent "cog" "cow" `shouldBe` True

        it "is false if words differ by more than one letter" $ do
            adjacent "foo" "bow" `shouldBe` False

    describe "adjacents" $ do
        it "given a list of words, yields all adjacents words" $ do
            M.toList (adjacents ws)  `shouldBe` 
                [("bag",["bat","bog","bug"])
                ,("bat",["bag","cat","fat"])
                ,("bog",["bag","bug","cog","dog","fog"])
                ,("bug",["bag","bog"])
                ,("cat",["bat","cot","fat"])
                ,("cog",["bog","cot","dog","fog"])
                ,("cot",["cat","cog"])
                ,("dog",["bog","cog","fog"])
                ,("fat",["bat","cat","fit"])
                ,("fig",["fit","fog"])
                ,("fit",["fat","fig"])
                ,("fog",["bog","cog","dog","fig"])]

    describe "ladders" $ do
        it "given a graph, a target, a list of path and a set of visited nodes, yields a list of paths" $ do
            let g = adjacents ws
                i = [["dog"]]
            ladders g "cog" i S.empty `shouldBe` [["cog","dog"]]



