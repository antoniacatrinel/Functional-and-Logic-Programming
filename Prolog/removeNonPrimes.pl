% Remove all non-prime numbers from a list.

% checkPrime(nr, div) = true, if nr = 2
%                     = true, if nr = 3
%                     = true, if nr % div != 0 and div >= nr / 2 and nr != 1
%                     = prime(nr, div + 2), if nr % div != 0 and nr != 1

% checks if a number is prime
% checkPrime(nr, div) = 
% = true, if nr = div
% = checkPrime(nr, div + 1), otherwise

checkPrime(2,_):-!.
checkPrime(3,_):-!.
checkPrime(N,D):- 
    N =\= 1,
    N mod D =\= 0,
    D >= N/2,
    !.
checkPrime(N,D):- 
    N =\= 1,
    N mod D =\= 0,
    D1 is D+2,
    checkPrime(N,D1).

/* Mathematical model:
    removeNonPrimes(l1l2...ln) = [], n = 0
                                 l1 + removeNonPrimes(l2...ln), isPrime(l1)
                                 removeNonPrimes(l2...ln), otherwise
*/

% removes all non-prime numbers from a list
% removeNonPrimes(L:list, R:list)
% flow model: (i, o), (i, i)

removeNonPrimes([], []).
removeNonPrimes([H|T], [H|R]) :-
    checkPrime(H, 2),
    !,
    removeNonPrimes(T, R).
removeNonPrimes([_|T], R) :-
    removeNonPrimes(T, R).

% tests for removeNonPrimes predicate

testCreatePairs:-
    removeNonPrimes([],[]),
    removeNonPrimes([11,22,11,22,11,33,11],[11,11,11,11]),
    removeNonPrimes([1,2,3,4],[2,3]).
