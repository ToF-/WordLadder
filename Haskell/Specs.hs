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

            describe "minus" $ do
                let r = [("COG","FOG"),("CAT","BAT")]
                let s = q `minus` r
                it "should remove from the first queue the edges that aim to words in the second queue" $ do
                    lookup "COG" s `shouldBe` Nothing 
                    lookup "CAT" s `shouldBe` Nothing 

            describe "the path from a starting word to an ending word" $ do
                it "should start with the edge from start to start" $ do
                    take 1 (path q "DOG" "CAT") `shouldBe` ["DOG"]

                it "should continue with the following step in the ladder" $ do
                    take 2 (path q "DOG" "CAT") `shouldBe` ["DOG","COG"]

                it "should continue until the end word is found" $ do
                    path q "DOG" "CAT" `shouldBe` ["DOG","COG","COT","CAT"]

                it "should be empty if the starting word is not in the list" $ do
                    path q "QUX" "CAT" `shouldBe` []

                it "should be empty if the endiong word is not in the list" $ do
                    path q "DOG" "QUX" `shouldBe` []

        describe "search" $ do
            describe "given a graph, a list of edges to traverse, a list of traversed edges" $ do
                let g = graph ws
                let q = [("FAT","BAT"),("CAT","COT"),("BAT","BAG")
                        ,("FOO","FOG"),("FIG","FOG"),("COT","COG")
                        ,("BUG","BOG"),("BAG","BOG"),("FOG","DOG")
                        ,("COG","DOG"),("BOG","DOG"),("DOG","DOG")]
                it "should stop when there's not edges to traverse" $ do
                    search g [] [("FOO","BAR")]  `shouldBe` [("FOO","BAR")] 

                it "should explore the edges breadth first" $ do
                    search g [("DOG","DOG")] [] `shouldBe` q

        describe "searchFor" $ do
            describe "given a graph, a target word, a list of edges to traverse, a list of traversed edges" $ do

                let g = graph ws
                let q = [("CAT","COT"),("BAT","BAG"),("FOO","FOG")
                        ,("FIG","FOG"),("COT","COG"),("BUG","BOG")
                        ,("BAG","BOG"),("FOG","DOG"),("COG","DOG")
                        ,("BOG","DOG"),("DOG","DOG")] 
                it "should stop when there's not edges to traverse" $ do
                    searchFor g "CAT" [] [("FOO","BAR")]  `shouldBe` [("FOO","BAR")] 

                it "should explore the edges breadth first" $ do
                    searchFor g "CAT" [("DOG","DOG")] [] `shouldBe` q

        describe "ladder, given a list of words" $ do
            describe "when a ladder between two words is feasible" $ do
                it "should find it" $ do
                    ladder ws "DOG" "CAT" `shouldBe` ["DOG","COG","COT","CAT"]
                    ladder ws "FIG" "CAT" `shouldBe` ["FIG","FOG","COG","COT","CAT"] 

            describe "when the starting word is not in the list" $ do
                it "should not find it" $ do
                    ladder ws "QUX" "CAT" `shouldBe` []

            describe "when the ending word is not in the list" $ do
                it "should not find it" $ do
                    ladder ws "DOG" "QUX" `shouldBe` []
    

