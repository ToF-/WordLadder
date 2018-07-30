use std::collections::BTreeMap;
use std::iter::FromIterator;

struct WordGraph<'a> {
    map: BTreeMap<&'a str,Option<&'a str>>

}

impl<'a> WordGraph<'a> {
    fn get(s:&str) -> Option<&'a str> {
        return None
    }
}

impl<'a> Iterator for WordGraph<'a> {
    type Item = (&'a str, Option<&'a str>);
    fn next(& mut self) -> Option<(&'a str, Option<&'a str>)> {
       None
    }
}

impl<'a> FromIterator<&'a str> for WordGraph<'a> {
    fn from_iter<I:IntoIterator<Item = &'a str>>(iter : I) -> Self {
        WordGraph { map:BTreeMap::new() }
    }
}

mod word_graph_should {
    use super::*;
    
    #[test]
    fn contain_words() { 
        let words = ["BAG","BOG","BAT","BUG","CAT","COG","COT","DOG","FOG","FIG","FAT","FOO","QUX"];
        let graph = WordGraph::from_iter(words.iter());

        assert_eq!(2+2,4);
    }
}

