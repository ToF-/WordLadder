
struct Edge<'a> {
    word: &'a str,
    from: Option<&'a str>
}

impl <'a> Edge<'a> {
    fn set_from(&mut self, word:&'a str) {
        self.from = Some(word)
    }
}
    

#[cfg(test)]
mod edge_should {
    use super::*;
    
    #[test]
    fn refer_to_a_word_and_a_node() {
        let edge = Edge { word: "BAG", from:None };

        assert_eq!(edge.word,"BAG");
        assert_eq!(edge.from,None);
    }
    #[test]
    fn change_its_from_key() {
        let mut edge = Edge { word: "BAG", from:None };
        edge.set_from("BUG");
        assert_eq!(edge.from,Some("BUG"));

    }
}

// let words = ["BAG","BOG","BAT BUG CAT COG COT DOG FOG FIG FAT FOO QUX"];
