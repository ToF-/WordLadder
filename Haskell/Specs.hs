import Test.Hspec
import Adjacents

main = hspec $ do
    let ws = words "cog dog fog log cow bow bat"
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
            adjacents ws  `shouldBe` 
                [("cog",["dog","fog","log","cow"])
                ,("dog",["cog","fog","log"])
                ,("fog",["cog","dog","log"])
                ,("log",["cog","dog","fog"])
                ,("cow",["cog","bow"])
                ,("bow",["cow"])]

    describe "ladder" $ do
        it "finds a 2 words ladder of adjacent words" $ do
            ladder ws "cog" "dog" `shouldBe` ["cog","dog"] 
            ladder ws "dog" "cog" `shouldBe` ["dog","cog"] 
        it "finds a 3 words ladder of adjacent words" $ do
            ladder ws "log" "cow" `shouldBe` ["log","cog","cow"] 
