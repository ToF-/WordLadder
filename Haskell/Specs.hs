import Test.Hspec
import Ladder

main = hspec $ do
    describe "given a list of words" $ do
        let ws = words "BAG BAT BOG BUG CAT COG COT DOG DOT FOG QUX" 
        describe "ladder" $ do
            let ladder_ s t = unwords (ladder ws s t)
            it "gives the adjacent words between a source and a target" $ do
                ladder_ "DOG" "CAT" `shouldBe` "DOG COG COT CAT" 

            it "gives a 2 step ladder when the words are adjacent" $ do
                ladder_ "DOG" "BOG" `shouldBe` "DOG BOG"
                ladder_ "DOG" "COG" `shouldBe` "DOG COG"
                ladder_ "BAG" "BAT" `shouldBe` "BAG BAT"

            it "gives nothing if the words are identical" $ do
                ladder_ "DOG" "DOG" `shouldBe` ""

                
            
