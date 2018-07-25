
1. Finding adjacent words

For any given word in the list, we can find its adjacent words. Two words are adjacent if

- they are the same size
- they differ only by one letter

2. Searching for a word

Using the graph of words, we can find edges. An edge is formed by a pair of adjacent words in the graph. When we see that the word DOG is adjacent with the words BOG, COG, FOG, then we have found the following edges:

    ("BOG","DOG")
    ("COG","DOG")
    ("FOG","DOG")

Given a graph of words, a target, a list of edges to traverse, and a list of edges already traversed, we traverse the graph, and halt on one of the two conditions:

- the list of edges to visit is empty, meaning that there is no possible ladder to the target word.
- the current edge being visited is aiming to the target word, meaning that (with this edge) we have visited enough edges to build our ladder.

This traversal works only if the following invariants hold:

- No word is ever visited twice (meaning that if we have found an edge ("FOG","DOG"), then the edge ("FOG","FIG") should not be processed.

This traversal finds the shortest possible ladder if the following hold:

- All the words that are adjacent to the word of the current edge are visited before words that are adjacent to these words.

3. Retrieving the ladder from the list of traversed edges

Given a list of edges (i.e. a pair (word, parent word)) that were visited during the search, and providing that there's a possible path between the start word and the end word, we can walk this path, until the beginning of the ladder, provided that:

- one of the edge in the list has the starting word as a parent node.
- the last edge traversed has the end word as a aim node.
