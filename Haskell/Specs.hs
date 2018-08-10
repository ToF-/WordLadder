import Test.Hspec
import Ladder

main = hspec $ do
    describe "adjacent" $ do
        it "is false with empty strings" $ do
            ""  `adjacent` ""  `shouldBe` False 

        it "is true with distinct one letter words" $ do
            "A" `adjacent` "B" `shouldBe` True  
