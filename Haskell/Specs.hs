import Test.Hspec
import Adjacents
import Data.List
import Data.Map as M (toList,fromList)

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

    describe "path" $ do
        it "given a list of edges, yields a path" $ do
            path "cat" (fromList ([("cat",(3,Just "cot"))
                                  ,("cot",(2,Just "cog"))
                                  ,("cog",(1,Just "dog"))
                                  ,("dog",(0,Nothing))]))
             `shouldBe` ["dog","cog","cot","cat"]

    describe "ladder" $ do
        it "given two adjacent words, finds the ladder" $ do
            ladder ws "dog" "fog" `shouldBe` ["dog","fog"]
            ladder ws "cot" "cat" `shouldBe` ["cot","cat"]

        it "given two equal words, finds nothing" $ do
            ladder ws "dog" "dog" `shouldBe` []

        it "given two distant words, finds nothing" $ do
            ladder ws "dog" "bug" `shouldBe` []

        it "given at least one non-existing word, finds nothing" $ do
            ladder ws "dog" "foo" `shouldBe` []
            ladder ws "bar" "cat" `shouldBe` []

        it "given words of different size, finds nothing" $ do
            ladder ws "do" "dog" `shouldBe` []

        it "given words at a distance of 2, finds the ladder" $ do
            ladder ws "dog" "fig" `shouldBe` ["dog","fog","fig"]

        it "given words at a distance of 3, finds the ladder" $ do
            ladder ws "dog" "fit" `shouldBe` ["dog","fog","fig","fit"]

        it "always finds the shortest ladder" $ do
            ladder ws "dog" "cat"  `shouldBe` ["dog","cog","cot","cat"]
            ladder (ws\\["cot"]) "dog" "cat"  `shouldBe` ["dog","bog","bag","bat","cat"]
            ladder (ws\\["cot","bag"]) "dog" "cat"  `shouldBe` ["dog","fog","fig","fit","fat","cat"]
        
