import Test.Hspec
import Ladder
import Data.List ((\\))

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

            it "should indicate a list of adjacent words for connected words" $ do
                lookup "BAT" g `shouldBe` Just ["BAG","CAT", "FAT"]
    describe "given a list of edges with a starting edge from a word to itself" $ do
        let q = [("COG","DOG"),("COT","COG"),("CAT","COT"),("DOG","DOG")]

        describe "a queue of edges" $ do
            it "should only contain the edges from the queue" $ do
                lookup "BAR" q `shouldBe` Nothing

            it "should contain an edge that has been inserted" $ do
                lookup "BAR" (insert ("BAR","BAT") q) `shouldBe` Just "BAT"

            it "should contain an edge to a given word only once" $ do
                lookup "COG" (insert ("COG","FOG") q) `shouldBe` Just "DOG"

        describe "union between queues" $ do
            let r = [("BOG","DOG"),("BUG","BOG"),("CAT","BAT")] 
            let s = q `union` r 

            it "should contain all the edges from the first queue" $ do
                mapM_ (\w -> (lookup w s /= Nothing) `shouldBe` True) (map fst q)

            it "should contain all the edges from the second queue" $ do
                mapM_ (\w -> (lookup w s /= Nothing) `shouldBe` True) (map fst r)
                
            it "should not contain the edges from the second queue that aim words from the first queue" $ do
                lookup "CAT" s `shouldBe` Just "COT"

            it "should be ordered so that the edges from the left queue are first" $ do
                s `shouldBe` q ++ (r\\[("CAT","BAT")])

