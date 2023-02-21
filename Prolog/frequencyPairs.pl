/* Create from a list of numbers, a list of pairs (N, Count), where Count is the number of times N appears in the list.
eg: [11, 22, 11, 22, 11, 33, 11] => [[11, 4], [22, 2], [33, 1]] */

/* Mathematical model:
    countOccurences(l1l2...ln, e) = 0, if n = 0
                                    1 + countOccurences(l2...ln, e), if l1 = e
                                    countOccurences(l2...ln, e), otherwise
*/

% counts the occurences of a number in a list
% countOccurences(L:list, E:number, R:number)
% flow model (i, i, o), (i,i,i)

countOccurences([], _, 0).
countOccurences([H|T], E, R):-
    H =:= E,
    !,
    countOccurences(T, E, R1),
    R is R1 + 1.
countOccurences([_|T], E, R):-
    countOccurences(T, E, R).

/* Mathematical model:
    removeOccurences(l1l2...ln, e) = [], if n = 0
                                     removeOccurences(l2l3...ln, e), if l1 = e
                                     {l1} U removeOccurences(l2l3...ln), otherwise
*/

% removes the occurences of a number in a list
% removeOccurences(L-list, E-number, R-list)
% flow model (i,i,o), (i,i,i)

removeOccurences([], _, []).
removeOccurences([H|T], E, R):-
    H =:= E,
    !,
    removeOccurences(T, E, R).
removeOccurences([H|T], E, [H|R]):-
    removeOccurences(T, E, R).

/* Mathematical model:
    createPairs(l1l2...ln) = [], if n = 0
                             [l1, countOccurences(l1l2...ln, l1)] + createPairs(l2...ln), otherwise
*/

% creates a list of pairs (N, frequency of N)
% createPairs(L:list, R:list)
% flow model (i, o), (i, i)

createPairs([], []).
createPairs([H|T], [[H, HFREQ]|R]):-
    countOccurences([H|T], H, HFREQ),
    removeOccurences(T, H, RR),
    createPairs(RR, R).

% tests for createPairs predicate

testCreatePairs:-
    createPairs([],[]),
    createPairs([11,22,11,22,11,33,11],[[11,4],[22,2],[33,1]]),
    createPairs([1,2,3,4],[[1,1],[2,1],[3,1],[4,1]]).
    