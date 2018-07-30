
struct Edge<'a> {
    word: &'a str,
    from: Option<&'a str>
}
    

#[cfg(test)]
mod edge_should {
    use super::*;
    
    #[test]
    fn refer_to_a_word_and_a_from_node() {
        let edge = Edge { word: "BAG", from:None };

        assert_eq!(edge.word,"BAG");
        assert_eq!(edge.from,None);
    }
}

// let words = ["BAG","BOG","BAT BUG CAT COG COT DOG FOG FIG FAT FOO QUX"];
