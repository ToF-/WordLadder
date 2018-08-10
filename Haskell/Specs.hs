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

    describe "path" $ do
        it "given a list of pairs of words, walk the pairs until the word with no parent" $ do
        let ws = [("FOO","BAR"),("BAR","QUX"),("QUX","")]
        path "FOO" ws `shouldBe` ["FOO","BAR","QUX"]

    describe "search" $ do
        describe "given a list of words, a target and an origin" $ do
            let ws = words "BAG BOG CAT COT COG DOG FOG QUX"
            it "collected visited edges until origin is found" $ do
                 search ws "CAT" "CAT" `shouldBe` [("CAT","")]

            it "gives an empty list if no words leads to origin" $ do
                 search ws "CAT" "QUX" `shouldBe` []
                 search ws "BAG" "CAT" `shouldBe` [("CAT","COT"),("COT","COG"),("FOG","BOG"),("DOG","BOG"),("COG","BOG"),("BOG","BAG"),("BAG","")]
