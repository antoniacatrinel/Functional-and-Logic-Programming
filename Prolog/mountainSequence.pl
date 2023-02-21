/* The list a1, ..., an is given and it consists of distinct integers. Write a predicate to determine all subsets with aspect of "mountain"
    (a set has a "mountain" aspect if the elements increase to a certain point and then decrease).
*/

/* Mathematical model:
    flag = 0, when the sequence is increasing
    flag = 1, when the sequence is decreasing
    
    mountain(l1l2...ln, f) = true, if f = 1 and n = 1
                             mountain(l2l3...ln, 0), if l1 < l2 and f = 0
                             mountain(l2l3...ln, 1), if l1 > l2 and (f = 0 or f = 1)
                             false, otherwise ((l1 < l2 and f = 1) or (n = 1 and f = 0))

    mainMountain(l1l2...ln) = mountain(l1l2...ln, 0), if l1 < l2
                              false, otherwise
*/

% checks if a list is of mountain aspect
% mountain (L-list, F-number 0/1)
% flow model (i, i)

mountain([_], 1):-!.
mountain([H1, H2|T], 0):-
    H1 < H2,
    !,
    mountain([H2|T], 0).
mountain([H1, H2|T], _):-
    H1 > H2,
    mountain([H2|T], 1).
      
% mainMountain(L-list)
% flow model (i)
    
mainMountain([H1, H2|T]):-
    H1 < H2,
    mountain([H1, H2|T], 0).


/* Mathematical model:
subsets(l1l2...ln) = [], if l1l2...ln = [] (n = 0)
                     {l1} U subsets(l2l3...ln), if n > 0
                     subsets(l2l3...ln), if n > 0  -> skip head of left list, right list is a subset of the tail of the left list
*/

% determines the list of subsets of a list
% subsets(L-list, R-result list)
% flow model (i, o), (i, i)

subsets([], []).
subsets([H|T], [H|R]):-
    subsets(T, R).
subsets([_|T], R):-
    subsets(T, R).

% finds a solution
% generateSolution(L-list, R-result list)
% flow model (i, o), (i, i)

generateSolution(L, R) :- 
    subsets(L, R),
    mainMountain(R).

% generates and unifies all partial solutions by backtracking
% allsolutions(L-list, R-result list)
% flow model (i, o), (i, i)

combineAll(L, R) :-
    findall(RR, generateSolution(L, RR), R).

% for the console:
% set_prolog_flag(answer_write_options, [max_depth(0)]).

% tests:

testAll:-
    combineAll([], []),
    combineAll([2], []),
    combineAll([2,3,3], []),
    combineAll([8,2,4], []),
    combineAll([8,2,4,6,4], [[2,4,6,4],[2,6,4],[4,6,4]]),
    combineAll([2,3,2,2,1], [[2,3,2,1],[2,3,2],[2,3,2,1],[2,3,2],[2,3,1]]),
    combineAll([7,7,3,4,5,4,3,6], [[3,4,5,4,3],[3,4,5,4],[3,4,5,3],[3,4,3],[3,5,4,3],[3,5,4],[3,5,3],[3,4,3],[4,5,4,3],[4,5,4],[4,5,3]]),
    combineAll([1,2,3,4,2], [[1,2,3,4,2],[1,2,3,2],[1,2,4,2],[1,3,4,2],[1,3,2],[1,4,2],[2,3,4,2],[2,3,2],[2,4,2],[3,4,2]]).
