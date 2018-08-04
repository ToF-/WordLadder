use std::collections::HashMap;
use std::collections::VecDeque;

#[derive(Debug, Eq, PartialEq)]
enum WordGraphResult {
    NoParent,
    Origin,
    Parent(String),
    UnknownWord,
}
use self::WordGraphResult::*;

#[derive(Default)]
pub struct WordGraph {
    words: HashMap<String, Option<String>>,
}

impl WordGraph {

    pub fn ladder<S: Into<String>>(&mut self, origin: S, target: S) -> Vec<String> {
        let origin = origin.into();
        let target = target.into();
        assert!(self.words.contains_key(&origin));
        assert!(self.words.contains_key(&target));

        self.breadth_search(origin.clone(), target.clone());
        self.path(target)
    }

    pub fn add<S: Into<String>>(&mut self, s: S) {
        self.words.insert(s.into(), None);
    }

    fn is_adjacent<S: Into<String>>(s1: S, s2: S) -> bool {
        let (s1, s2) = (s1.into(), s2.into());
        if s1.len() != s2.len() {
            return false;
        }

        s1.chars()
            .zip(s2.chars())
            .filter(|(c1, c2)| c1 != c2)
            .count() == 1
    }

    fn adjacent_of<S: Into<String>>(&self, key: S) -> Vec<String> {
        let key = key.into();
        assert!(self.words.contains_key(&key));

        self.words
            .keys()
            .filter(|word| WordGraph::is_adjacent(key.clone(), (*word).clone()))
            .map(String::clone)
            .collect()
    }

    fn get<S: Into<String>>(&self, key: S) -> WordGraphResult {
        let key = key.into();

        match self.words.get(&key) {
            None => UnknownWord,
            Some(None) => NoParent,
            Some(Some(parent)) if parent == &key => Origin,
            Some(Some(parent)) => Parent(parent.clone()),
        }
    }

    fn update_parent<S: Into<String>>(&mut self, key: S, parent: S) {
        let key = key.into();
        self.words
            .entry(key)
            .and_modify(|entry| *entry = Some(parent.into()));
    }

    fn path<S: Into<String>>(&self, target: S) -> Vec<String> {
        let target = target.into();
        assert!(self.words.contains_key(&target));

        match self.get(target.clone()) {
            Origin => vec![target],
            Parent(parent) => [self.path(parent), vec![target]].concat(),
            NoParent => unimplemented!("NoParent should not be on the path"),
            UnknownWord => unimplemented!("UknownWord should not be on the path"),
        }
    }

    fn mark_origin<S: Into<String>>(&mut self, key: S) {
        let key = key.into();
        assert!(self.words.contains_key(&key));

        self.words
            .entry(key.clone())
            .and_modify(|entry| *entry = Some(key));
    }

    fn breadth_search<S: Into<String>>(&mut self, origin: S, target: S) {
        let origin = origin.into();
        let target = target.into();
        assert!(self.words.contains_key(&origin));
        assert!(self.words.contains_key(&target));

        self.mark_origin(origin.clone());
        let mut to_visit = VecDeque::new();
        to_visit.push_front(origin.clone());

        while let Some(current) = to_visit.pop_front() {
            if current == target {
                assert_ne!(self.get(current), NoParent);
                return
            }

            for neighbour in self.adjacent_neighbours(current.clone()) {
                self.update_parent(neighbour.clone(), current.clone());
                to_visit.push_back(neighbour.clone());
            }
        }
    }

    fn adjacent_neighbours<S: Into<String>>(&self, node: S) -> Vec<String> {
        let node = node.into();

        self.adjacent_of(node.clone())
            .into_iter()
            .filter(|node| self.get((*node).clone()) == NoParent)
            .collect()
    }
}

#[cfg(test)]
mod test {
    use super::*;

    mod is_adjacent {
                use super::*;

                fn check_adjacent(s1: &str, s2: &str) {
                assert_eq!(WordGraph::is_adjacent(s1, s2), true);
                }

                fn check_not_adjacent(s1: &str, s2: &str) {
                assert_eq!(WordGraph::is_adjacent(s1, s2), false);
                }

                #[test]
                fn should_be_false_if_words_are_identical() {
                check_not_adjacent("CAT", "CAT")
                }

                #[test]
                fn should_be_true_if_words_are_different_by_one_letter() {
                check_adjacent("CAT", "BAT")
                }

                #[test]
                fn should_be_false_if_words_are_different_by_more_than_one_letter() {
                check_not_adjacent("CAT", "BIT")
                }

                #[test]
                fn should_be_true_if_words_are_different_by_one_letter_in_the_middle_of_the_word() {
                check_adjacent("AST", "AFT");
                }

                #[test]
                fn should_be_false_if_words_have_different_sizes() {
                check_not_adjacent("T", "BAT")
                }

                #[test]
                fn should_be_false_if_one_word_is_empty() {
                check_not_adjacent("", "BAT");
                check_not_adjacent("BAT", "");
                }
                }

    mod adjacent_of {
                use super::*;

                #[test]
                fn it_should_find_the_adjacent_words_of_a_word() {
                let mut word_graph = WordGraph::default();
                word_graph.add("CAT");
                word_graph.add("BAT");
                word_graph.add("COT");
                word_graph.add("FAT");

                let mut adjacents = word_graph.adjacent_of("CAT");
                let mut expected: Vec<String> = vec!["BAT", "COT", "FAT"]
                .into_iter()
                .map(String::from)
                .collect();

                assert_eq!(adjacents.sort(), expected.sort());
                }
                }

    mod get {
        use super::*;

        #[test]
        fn it_should_not_contain_a_word_when_empty() {
        let word_graph = WordGraph::default();
        assert_eq!(word_graph.get("CAT"), UnknownWord)
        }

        #[test]
        fn it_should_contain_a_word_when_word_was_added() {
        let mut word_graph = WordGraph::default();
        word_graph.add("CAT");
        assert_eq!(word_graph.get("CAT"), NoParent)
        }

        #[test]
        fn it_should_contain_a_word_with_a_parent_when_word_was_updated() {
        let mut word_graph = WordGraph::default();
        word_graph.add("CAT");
        word_graph.update_parent("CAT", "BAT");
        assert_eq!(word_graph.get("CAT"), Parent(String::from("BAT")))
        }
        }

    mod path {
         use super::*;

         #[test]
         fn it_should_find_a_one_step_path() {
         // given
         let mut word_graph = WordGraph::default();
         word_graph.add("CAT");
         word_graph.mark_origin("CAT");
         // when
         let strings = word_graph.path("CAT");
         // assert
         assert_eq!(vec!["CAT"], strings)
         }

         #[test]
         fn it_should_find_a_two_step_path() {
         // given
         let mut word_graph = WordGraph::default();
         word_graph.add("CAT");
         word_graph.mark_origin("CAT");
         word_graph.add("COT");
         word_graph.update_parent("COT", "CAT");
         // when
         let strings = word_graph.path("COT");
         // assert
         assert_eq!(vec!["CAT", "COT"], strings)
         }

         #[test]
         fn it_should_find_a_complete_path() {
         // given
         let mut word_graph = WordGraph::default();
         word_graph.add("CAT");
         word_graph.mark_origin("CAT");
         word_graph.add("COT");
         word_graph.update_parent("COT", "CAT");
         word_graph.add("DOT");
         word_graph.update_parent("DOT", "COT");
         word_graph.add("DOG");
         word_graph.update_parent("DOG", "DOT");
         // when
         let strings = word_graph.path("DOG");
         // assert
         assert_eq!(vec!["CAT", "COT", "DOT", "DOG"], strings)
         }
         }

    mod mark_origin {
                use super::*;

                #[test]
                fn it_should_make_a_word_its_own_parent() {
                let mut word_graph = WordGraph::default();
                word_graph.add("CAT");
                // when
                word_graph.mark_origin("CAT");
                // then
                assert_eq!(Origin, word_graph.get("CAT"));
                }
                }

    mod breadth_search {
                   use super::*;

                   #[test]
                   fn it_should_find_a_two_step_ladder() {
                   let mut word_graph = WordGraph::default();
                   word_graph.add("CAT");
                   word_graph.add("BAT");
                   // arrange
                   word_graph.breadth_search("CAT", "BAT");
                   // assert
                   assert_eq!(vec!["CAT", "BAT"], word_graph.path("BAT"))
                   }

                   #[test]
                   fn it_should_find_a_three_step_ladder() {
                   let mut word_graph = WordGraph::default();
                   word_graph.add("CAT");
                   word_graph.add("BAT");
                   word_graph.add("BAG");
                   // arrange
                   word_graph.breadth_search("CAT", "BAG");
                   // assert
                   assert_eq!(vec!["CAT", "BAT", "BAG"], word_graph.path("BAG"))
                   }
                   }

    mod ladder {
           use super::*;

           #[test]
           fn it_should_find_a_ladder_between_two_words() {
           let mut word_graph = WordGraph::default();
           for word in [
           "FOO", "FOG", "FIG", "DOG", "COG", "BOG", "BUG", "BAG", "BAT", "FAT", "CAT",
           "COT",
           ].into_iter()
           {
           word_graph.add(*word)
           }

           let strings = word_graph.ladder("DOG", "CAT");
           let expected : Vec<String> = vec!["DOG", "COG", "COT", "CAT"].into_iter().map(String::from).collect();

           assert_eq!(strings, expected);
           }
           }
}
