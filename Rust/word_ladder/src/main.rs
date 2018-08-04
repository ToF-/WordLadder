fn main() {
    println!("Hello, world!");
}

#[cfg(test)]
mod word_ladder {
    mod adjacent {
        #[test]
        fn should_be_false_if_words_are_identical() {
          assert_eq!(adjacent(String::from("CAT"),String::from("CAT")),false)
      
}
