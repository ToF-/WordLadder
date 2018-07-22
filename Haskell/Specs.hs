import Test.Hspec
import Ladder

main = hspec $ do
    describe "given a list of words" $ do
        let ws = words "BAG BOG BUG CAT COG COT DOG DOT FOG QUX" 
        describe "ladder" $ do
            let ladder_ s t = unwords (ladder ws s t)
            it "gives the adjacent words between a source and a target" $ do
                ladder_ "DOG" "CAT" `shouldBe` "DOG COG COT CAT" 

            it "gives nothing if the words are identical" $ do
                ladder_ "DOG" "DOG" `shouldBe` ""

                
            
