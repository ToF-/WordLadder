import Test.Hspec
import Ladder

main = do 
    hspec $ do
    describe "given a list of words" $ do
        let ws = words "BAG BOG BAT BUG CAT COG COT DOG FOG FIG FAT FOO QUX"

        describe "a graph of adjacent words" $ do
            let g = graph ws
            it "should contain only the words from the list" $ do
                lookup "BAR" g `shouldBe` Nothing
            
            it "should indicate an empty list for words with no adjacent words" $ do
                lookup "QUX" g `shouldBe` Just []

                

