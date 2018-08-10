import Test.Hspec
import Ladder

main = hspec $ do
    describe "adjacent" $ do
        it "is false with empty strings" $ do
            ""  `adjacent` ""  `shouldBe` False 

        it "is true with distinct one letter words" $ do
            "A" `adjacent` "B" `shouldBe` True  

        it "is false with identical one letter words" $ do
            "A" `adjacent` "A" `shouldBe` False

        it "is true when words differ by their first letter" $ do
            "DO" `adjacent` "GO" `shouldBe` True

        it "is true when words differ by only one letter" $ do
            "DOG" `adjacent` "DIG" `shouldBe` True
            "DOG" `adjacent` "GOT" `shouldBe` False

    describe "adjacents" $ do
        it "given a list, finds the adjacent words of a word" $ do
            let ws = words "CAT COT COG DOG FOG QUX"
            adjacents ws "DOG" `shouldBe` ["COG","FOG"]

    describe "add" $ do
        it "given a queue and a pair, returns a queue containing the pair" $ do
            let q = add ("FOO","BAR") []
            lookup "FOO" q `shouldBe` Just "BAR"

        it "adds a pair only if it not already in the queue" $ do
            let q = add ("FOO","QUX") (add ("FOO","BAR") [])
            lookup "FOO" q `shouldBe` Just "BAR"

        it "adds a pair at the end of a queue" $ do
            let q = add ("QUX","FOO") $
                    add ("BAZ","QUX") $
                    (add ("FOO","BAR") [])
            head q `shouldBe` ("FOO","BAR")
            head (tail q) `shouldBe` ("BAZ","QUX")
