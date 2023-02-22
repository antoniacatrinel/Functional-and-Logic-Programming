# Prolog Programming

Implement in **SWI Prolog** the following problems:

### 1. Create sublist
Write a predicate to create the sublist (lm, ..., ln) from the list (l1, ..., lk), where m >= 1 and n <= k.

### 2. Frequency pairs
Create from a list of numbers, a list of pairs (N, Count), where Count is the number of times N appears in the list.\
*Example: [11, 22, 11, 22, 11, 33, 11] => [[11, 4], [22, 2], [33, 1]].*

### 3. Longest even sequence
Define a predicate to determine the longest sequence of consecutive even numbers (if exist more maximal sequences one of them).

### 4. Lowest common multiple
Given a numerical linear list consisting of integers, write a predicate to compute the lowest common multiple of all elements from the list.
*Example: [2 4 3 5] => 60, [2 8 4 5 1] => 40, [4 3 9 0 2] => 36, [2 7 3 5 11] => 2310.*

### 5. Mountain sequence
The list a1, ..., an is given and it consists of distinct integers. Write a predicate to determine all subsets with aspect of "mountain" (a set has a "mountain" aspect if the elements increase to a certain point and then decrease).

### 6. Remove non primes
Remove all non-prime numbers from a list.

### 7. Replace sublist
For a heterogeneous list, formed from integer numbers and lists of numbers, define a predicate to replace every sublist with the longest sequences of even numbers from that sublist.
*Example: [1, [2, 1, 4, 6, 7], 5, [1, 2, 3, 4], 2, [1, 4, 6, 8, 3], 2, [1, 5], 3] => [1, [4, 6], 5, [2], 2, [4, 6, 8], 2, [], 3]*

### 8. Subsitute element
Write a predicate to substitute an element from a list with another element in the list.
