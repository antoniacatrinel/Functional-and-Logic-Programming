/* For a heterogeneous list, formed from integer numbers and lists of numbers, define a predicate to replace every sublist with the longest 
      sequences of even numbers from that sublist.
      Eg.: [1, [2, 1, 4, 6, 7], 5, [1, 2, 3, 4], 2, [1, 4, 6, 8, 3], 2, [1, 5], 3] => [1, [4, 6], 5, [2], 2, [4, 6, 8], 2, [], 3]
*/

/* Mathematical model:
    is_list(l1l12...ln) = true, if n = 0 (l1l2...ln = [])
                          is_list(l213...ln), if var(l1) = false 
                          false, otherwise
*/

% checks if a variable is a list
% is_list(L-list)
% flow model (i)

is_list([]).
is_list(L) :-
    var(L),      
    !,
    fail.
is_list([_|T]) :-
    is_list(T).

/* Mathematical model:
    even(N) = true, if N % 2 == 0
              false, otherwise
*/

% checks if a number is even
% even(N-number) 
% flow model (i)

even(N):-
    N mod 2 =:= 0.

/*  Mathematical model:
    appendToList(l1l2...ln, e) = [e], if n = 0 (l1l2...ln = [])
                                 {l1} U appendToList(l2l3...ln, e), otherwise
*/

% appends an element to a list
% appendToList(L-list, E-number, R-result list)
% flow model (i,i,o), (i,i,i)

appendToList([], E, [E]).
appendToList([H|T], E, [H|R]):-
    appendToList(T, E, R).

/* Mathematical model:
    lengthOfList(l1l2...ln) = 0, if n = 0 (l1l2...ln = [])
                              1 + lengthOfList(l2l3...ln), otherwise
*/

% computes the length of a list
% lengthOfList(L-list, N-result number)
% flow model (i,o), (i,i)

lengthOfList([], 0).
lengthOfList([_|T], N1):-
    lengthOfList(T, N),
    N1 is N + 1.

/* Mathematical model:
    l1l2...ln = initial list
    p1p2...pm = current longest sequence of even numbers
    r1r2...rk = the current sequence that we are constructing
    longestSeqEven(l1l2...ln, p1p2...pm, r1r2...rk) = p1p2...pm, if n = 0 and m >= k 
                                                      r1r2...rk, if n = 0 and k > m
                                                      longestSeqEven(l2l3...ln, p1p2...pm, {l1} U r1r2...rk), if even(l1) = true
                                                      longestSeqEven(l2l3...ln, p1p2...pm, []), if even(l1) = false and m >= k 
                                                      longestSeqEven(l2l3...ln, r1r2...rl, []), if even(l1) = false and k > m
*/

% computes the longest sequence of consecutive even numbers
% longestSeqEven(L-list, C-list, AUX-list, R-list)
% flow model (i,i,i,o), (i,i,i,i)

longestSeqEven([], C, AUX, C):-
    lengthOfList(C, LC),
    lengthOfList(AUX, LAUX),
    LC >= LAUX,
    !.
longestSeqEven([], C, AUX, AUX):-
    lengthOfList(C, LC),
    lengthOfList(AUX, LAUX),
    LC < LAUX,
    !.
longestSeqEven([H|T], C, AUX, R):-
    even(H),
    !,
    appendToList(AUX, H, NEWAUX),
    longestSeqEven(T, C, NEWAUX, R).
longestSeqEven([_|T], C, AUX, R):-
    lengthOfList(C, LC),
    lengthOfList(AUX, LAUX),
    LC >= LAUX,
    !,
    longestSeqEven(T, C, [], R).
longestSeqEven([_|T], C, AUX, R):-
    lengthOfList(C, LC),
    lengthOfList(AUX, LAUX),
    LC < LAUX,
    !,
    longestSeqEven(T, AUX, [], R).

% mainLongestSeqEven(L-list, R-result list)
% flow model (i,o), (i,i)

mainLongestSeqEven(L, R):-
    longestSeqEven(L,[],[],R).

/*
Mathematical model:
      replaceSublists(l1l2...ln) = [], if n = 0 (l1l2...ln = [])
                                   longestSeqEven2(l1, [], []) U replaceSublists(l2l3...ln), if l1 is list
                                   {l1} U replaceSublists(l2l3...ln), otherwise (l1 is number)
*/

% replaceSublists(L-list, R-result list)
% flow model (i,o), (i,i)

replaceSublists([], []).
replaceSublists([H|T], [HR|TR]):-
    is_list(H),
    !,
    mainLongestSeqEven(H, HR),      % or longestSeqEven(H, [], [], HR),
    replaceSublists(T, TR).
replaceSublists([H|T], [H|R]):-
    replaceSublists(T, R).

testReplaceSublists:-
    replaceSublists([], []),
    replaceSublists([[], 2, [2]], [[], 2, [2]]),
    replaceSublists([1, [2, 1, 4, 6, 7], 5, [1, 2, 3, 4], 2, [1, 4, 6, 8, 3], 2, [1, 5], 3], [1, [4, 6], 5, [2], 2, [4, 6, 8], 2, [], 3]),
    replaceSublists([1, 3, 5], [1, 3, 5]),
    replaceSublists([[2, 1], 5, 7, 8, [1, 7, 3, 5], 2, [1, 4, 6, 8, 3]], [[2], 5, 7, 8, [], 2, [4, 6, 8]]).
