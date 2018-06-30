import Test.Hspec
import Adjacents

main = hspec $ do
    let ws = words "dog fog fig fit fat cat cog cot bug"
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
                [("dog",["fog","cog"])
                ,("fog",["dog","fig","cog"])
                ,("fig",["fog","fit"])
                ,("fit",["fig","fat"])
                ,("fat",["fit","cat"])
                ,("cat",["fat","cot"])
                ,("cog",["dog","fog","cot"])
                ,("cot",["cat","cog"])]

    describe "path" $ do
        it "given a list of edges, yields a path" $ do
            path "cat" [("cat",Just "cot")
                       ,("fat",Just "fit")
                       ,("cot",Just "cog")
                       ,("cog",Just "dog")
                       ,("dog",Nothing)]
             `shouldBe` ["dog","cog","cot","cat"]

    describe "ladder" $ do
        it "given a list of words a start and end, yields a path from start to end" $ do
            ladder ws "dog" "cat" `shouldBe` ["dog","cog","cot","cat"]
