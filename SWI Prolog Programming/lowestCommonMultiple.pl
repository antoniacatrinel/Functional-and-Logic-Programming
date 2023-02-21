/*
Given a numerical linear list consisting of integers, write a predicate to compute the lowest common multiple of all elements from the list.
E.g. [2 4 3 5] -> 60
     [2 8 4 5 1] -> 40
     [4 3 9 0 2] -> 36
     [2 7 3 5 11] -> 2310
*/

/* Mathematical model:
    gcd(a, b) = a, if b = 0
                b, if a = 0
                gcd(a%b, b), if a >= b
                gcd(a, b%a), if a < b
*/

% computes the greates common divisor of 2 numbers
% gcd(A:number, B:number, R:number)
% flow model (i,i,i), (i,i,o)

gcd(0, B, B):-!.
gcd(A, 0, A):-!.
gcd(A, B, R):-
    A >= B,
    !,
    A1 is A mod B,
    gcd(A1, B, R).
gcd(A, B, R):-
    B1 is B mod A,
    gcd(A, B1, R).

/* Mathematical model:
    lcmNumbers(a, b) = a * b / gcd(a, b)
*/

% computes the lowest common multiple of 2 numbers
% lcmNumbers(A:number, B:number, R:number)
% flow model (i,i,i), (i,i,o)

lcmNumbers(A, B, R):-
    gcd(A, B, R1),
    R is A * B / R1.

/* Mathematical model:
    lcmList(l1l2...ln) = [l1], if n = 1
                         lcmNumbers(l1, lcmList(l2l3...ln)), otherwise
*/

% computes the lowest common multiple of all elements from a list
% lcmList(L:list, R:number)
% flow model (i,i), (i,o)

lcmList([H], H):-!.
lcmList([H|T], R):-
    H > 0,
    !,
    lcmList(T, R1),
    lcmNumbers(H, R1, R).
lcmList([_|T], R):-
    lcmList(T, R).

% tests for lcmList predicate

testAll:-
    lcmList([2,4,3,5], 60),
    lcmList([2,8,4,5,1], 40),
    lcmList([4,3,9,0,2], 36),
    lcmList([2,7,3,5,11], 2310).
