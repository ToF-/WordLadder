import Test.Hspec
import Adjacents
import Data.List as L
import Data.Map as M (toList,fromList,lookup)
import Data.Set as S

ws = ["ace","act","add","ado","aft","age","ago","aid","aim","air","ale","all","amp","ana","and","ant"
     ,"any","ape","apt","arc","are","ark","arm","art","ash","ask","asp","ass","ate","auk","awe","axe"
     ,"aye","bad","bag","ban","bap","bar","bat","bay","bed","bee","beg","bet","bib","bid","big","bin"
     ,"bit","boa","bob","bog","boo","bop","bow","box","boy","bra","bud","bug","bun","bus","but","buy"
     ,"bye","cab","cad","cam","can","cap","car","cat","chi","cob","cod","cog","col","con","cot","cow"
     ,"cox","coy","cry","cub","cud","cue","cup","cur","cut","dab","dam","day","den","dew","did","die"
     ,"dig","dim","din","dip","doe","dog","don","dot","dry","dub","dud","due","dug","dun","duo","dye"
     ,"ear","eat","ebb","eel","egg","ego","eke","elf","elk","ell","elm","emu","end","eon","era","erg"
     ,"err","eta","eve","ewe","eye","fad","fag","fan","far","fat","fax","fed","fee","fen","few","fib"
     ,"fig","fin","fir","fit","fix","fly","fob","foe","fog","fop","for","fox","fro","fry","fug","fun"
     ,"fur","gad","gag","gap","gas","gay","gel","gem","get","gig","gin","gnu","god","got","gum","gun"
     ,"gut","guy","had","hag","ham","has","hat","hay","hem","hen","her","hew","hex","hey","hid","him"
     ,"hip","his","hit","hmm","hob","hod","hoe","hog","hop","hot","how","hub","hue","hug","huh","hum"
     ,"hut","ice","icy","ids","ifs","ilk","ill","imp","ink","inn","ins","ion","ire","its","ivy","jab"
     ,"jag","jam","jar","jaw","jay","jet","jib","jig","job","jog","jot","joy","jug","jut","keg","ken"
     ,"key","kid","kin","kit","lad","lag","lap","law","lax","lay","lea","led","lee","leg","let","lid"
     ,"lie","lip","lit","lob","log","lop","lot","low","lug","lux","lye","mad","man","map","mar","mat"
     ,"maw","may","men","met","mew","mix","mob","mop","mow","mud","mug","mum","nag","nap","nay","nee"
     ,"net","new","nib","nil","nip","nit","nod","nor","not","now","nub","nun","nut","oaf","oak","oar"
     ,"oat","odd","ode","off","oft","ohm","oil","old","one","ooh","opt","orb","ore","our","out","ova"
     ,"owe","owl","own","pad","pal","pan","pap","par","pat","paw","pay","pea","peg","pen","per","pet"
     ,"pew","phi","pie","pig","pin","pip","pit","ply","pod","pop","pot","pox","pro","pry","pub","pug"
     ,"pun","pup","pus","put","qua","rag","raj","ram","ran","rap","rat","raw","ray","red","rho","rib"
     ,"rid","rig","rim","rip","rob","rod","roe","rot","row","rub","rue","rug","rum","run","rut","rye"
     ,"sad","sag","sap","sat","saw","say","sea","sec","see","set","sew","sex","she","shy","sic","sin"
     ,"sip","sir","sit","six","ski","sky","sly","sob","sod","son","sop","sot","sow","soy","spa","spy"
     ,"sty","sud","sue","sum","sun","sup","tab","tag","tan","tap","tar","tau","tax","tea","tee","ten"
     ,"the","thy","tic","tie","tin","tip","tit","toe","ton","too","top","tor","tot","tow","toy","try"
     ,"tub","tug","tun","two","ugh","ups","urn","use","van","vat","vet","vex","via","vie","voe","vow"
     ,"wad","wag","wan","war","was","wax","way","web","wed","wee","wet","who","why","wig","win","wit"
     ,"woe","wok","won","woo","wow","wry","yak","yam","yap","yaw","yea","yen","yes","yet","yew","yon"
     ,"you","zip","zoo"]

main = hspec $ do

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
            M.lookup "ace" (adjacents ws) `shouldBe` 
                Just ["act","age","ale","ape","are","ate","awe","axe","aye","ice"]

            M.lookup "zoo" (adjacents ws) `shouldBe` 
                Just ["boo","too","woo"]

            L.length (M.toList (adjacents ws)) `shouldBe` L.length ws

            [s | (s,ns) <- M.toList (adjacents ws), L.null ns] `shouldBe`
                ["ebb","emu","gnu","ohm","ooh","ova","qua","ugh","ups","urn","use"]
            

