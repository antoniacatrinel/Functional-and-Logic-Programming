% Define a predicate to determine the longest sequence of consecutive even numbers (if exist more maximal sequences one of them).

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

% tests for mainLongestSeqEven predicate

testLongestSeqEven:-
    mainLongestSeqEven([], []),
    mainLongestSeqEven([1, 2, 4, 6, 8, 3, 4, 8, 10, 9], [2, 4, 6, 8]),
    mainLongestSeqEven([1, 3, 5, 7, 9], []),
    mainLongestSeqEven([6, 8, 8, 10], [6, 8, 8, 10]),
    mainLongestSeqEven([6, 8, 7, 8, 10], [6, 8]).
