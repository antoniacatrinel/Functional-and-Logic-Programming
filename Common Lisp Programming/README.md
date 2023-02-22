# Lisp Programming

Implement in **Common Lisp** the following problems:

### 1. Association list
Write a function to return an association list with the two lists given as parameters. \
*Example: (A B C) (X Y Z) => ((A.X) (B.Y) (C.Z)).*

### 2. Convert binary tree
A binary tree is memorised in the following two ways:
 1. (node no-subtrees list-subtree-1 list-subtree-2 ...)
 2. (node (list-subtree-1) (list-subtree-2) ...)

Convert a tree of type 1 to type 2.

### 3. Count numerical atoms
Write a function to return the number of all numerical atoms in a list at superficial level.

### 4. Count sublists any level
Write a function to determine the number of all sublists of a given list, on any level.
A sublist is either the list itself, or any element that is a list, at any level. \
*Example: (1 2 (3 (4 5) (6 7)) 8 (9 10)) => 5 lists: (list itself, (3 ...), (4 5), (6 7), (9 10)).*

### 5. Depth list
Compute the depth of a non-linear list.

### 6. Duplicate nth element
Write twice the n-th element of a linear list. \
*Example: (10 20 30 40 50) and n = 3 => (10 20 30 30 40 50).*

### 7. List to set
Transform a linear list into a set.

### 8. Path to node
A binary tree is memorised in the following two ways:
 1. (node no-subtrees list-subtree-1 list-subtree-2 ...)
 2. (node (list-subtree-1) (list-subtree-2) ...)
 
For a given tree of type 2 return the path from the root node to a certain given node X.

### 9. Replace sublists
Replace each sublist of a list with its last element.

### 10. Replace tree node
Define a function that replaces one node with another one in a n-tree represented as: \
(root list_of_nodes_subtree1... list_of_nodes_subtreen) \
*Example: tree is (a (b (c)) (d) (e (f))) and node 'b' will be replaced with node 'g' => tree (a (g (c)) (d) (e (f))).*

### 11. Vector dot product
Write a function to return the [dot product](https://en.wikipedia.org/wiki/Dot_product) of two vectors. 
