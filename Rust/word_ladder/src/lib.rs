use std::collections::BTreeMap;
use std::iter::FromIterator;
use std::str::Chars;

struct WordGraph {
    map: BTreeMap<String,String>

}

impl WordGraph {
    fn get(&self, s:String) -> Option<&String> {
        self.map.get(&s)
    }

    fn add(&mut self, s:String) {
        let t = s.clone();
        self.map.insert(s, t);
    }
    fn update(&mut self, s:String, t:String) {
        let t = t.clone();
        self.map.remove(&s);
        self.map.insert(s, t);
    }
    fn remove(&mut self, s:String) {
        self.map.remove(&s);
    }
    fn adjacents(&mut self, s:String) -> Option<Vec<String>> {
        fn adjacent(s:&String, t:&String) -> bool {
            let mut d = 0;
            for it in s.chars().zip(t.chars()) {
                let (a, b) = it;
                if a != b {
                    d = d + 1
                }
            }
            d == 1
        };
        let result : Vec<String> = self.map.iter().map(|(s,_)| s.clone()).filter(|t| adjacent(&s,t)).collect();
        Some(result.clone())
    }
    
}

impl Iterator for WordGraph {
    type Item = (String, Option<String>);
    fn next(& mut self) -> Option<(String, Option<String>)> {
       None
    }
}

impl FromIterator<String> for WordGraph {
    fn from_iter<I:IntoIterator<Item = String>>(iter : I) -> Self {
        let mut graph = WordGraph { map:BTreeMap::new().clone() };
        for s in iter {
             graph.add(s);
        }
        graph
    }
}
#[cfg(test)]
mod word_graph_should {
    use super::*;
    
    #[test]
    fn not_contain_a_word_when_empty() {
        let graph = WordGraph { map:BTreeMap::new() };
        assert_eq!(graph.get(String::from("BAG")), None)
    }
    #[test]
    fn contain_a_word_when_added() {
        let mut graph = WordGraph { map:BTreeMap::new() };
        graph.add(String::from("BAG"));
        assert_eq!(graph.get(String::from("BAG")), Some(&String::from("BAG")))
    }
    #[test]
    fn not_contain_a_word_when_removed() {
        let mut graph = WordGraph { map:BTreeMap::new() };
        graph.add(String::from("BAG"));
        assert_eq!(graph.get(String::from("BAG")), Some(&String::from("BAG")));
        graph.remove(String::from("BAG"));
        assert_eq!(graph.get(String::from("BAG")), None)
    }
    #[test]
    fn change_a_word_with_a_parent_word() {
        let mut graph = WordGraph { map:BTreeMap::new() };
        graph.add(String::from("BAG"));
        assert_eq!(graph.get(String::from("BAG")), Some(&String::from("BAG")));
        graph.update(String::from("BAG"),String::from("BUG"));
        assert_eq!(graph.get(String::from("BAG")), Some(&String::from("BUG")))

    }
    #[test]
    fn contain_words_when_filled_from_an_iterator() { 

        let words : Vec<String> = [
            "BAG", "BOG", "BAT", "BUG", "CAT", "COG", "COT", "DOG", "FOG", "FIG", "FAT", "FOO",
            "QUX",
        ]
            .iter()
            .map(|s| String::from(*s))
            .collect();
        let graph = WordGraph::from_iter(words.into_iter());

        assert_eq!(graph.get(String::from("BAG")),Some(&String::from("BAG")));
        assert_eq!(graph.get(String::from("COG")),Some(&String::from("COG")))
    }
    #[test]
    fn find_the_adjacent_words_of_a_word() {
        let words : Vec<String> = [
            "BAG", "BOG", "BAT", "BUG", "CAT", "COG", "COT", "DOG", "FOG", "FIG", "FAT", "FOO",
            "QUX",
        ]
            .iter()
            .map(|s| String::from(*s))
            .collect();
        let mut graph = WordGraph::from_iter(words.into_iter());
        
        let adjs : Vec<String> = [
            "BOG", "COG", "FOG"
        ]
            .iter()
            .map(|s| String::from(*s))
            .collect();
        assert_eq!(graph.adjacents(String::from("DOG")),Some(adjs));
    }
}

