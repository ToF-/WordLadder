import Test.Hspec
import Ladder

main = hspec $ do
    describe "adjacent" $ do
        it "is false with empty strings" $ do
            ""  `adjacent` ""  `shouldBe` False 
