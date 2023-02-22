% Write a predicate to create the sublist (lm, ..., ln) from the list (l1,..., lk).

/* Mathematical model:
l1l2...lk - initial list
position - current position where we are in the list, is initialized with 0 at the beginning
m - start position of the resulting sublist
n - end position of the resulting sublist

createSublist(l1l2...lk, position, m, n) = [],  if position > n
                                         = {l1} U createSublist(l2...lk, position + 1, m, n), if position <= n and position >= m
                                         = createSublist(l2...lk, position + 1, m, n), otherwise  

*/

% createSublist(L:list, POSITION:number, M:number, N:number, R:list)
% flow model (i, i, i, i, o)
                                               
                                               
createSublist([],_,_,_,[]).                   
createSublist([H|T],POSITION,M,N,[H|R]):-     
    POSITION>=M,                               
    POSITION=<N,
    !,                                          
    NEWPOSITION is POSITION+1,                  
    createSublist(T,NEWPOSITION,M,N,R).
createSublist([_|T],POSITION,M,N,R):-                                        
    POSITION>N,
    !.                                
createSublist([_|T],POSITION,M,N,R):-
    NEWPOSITION is POSITION+1,                 
    createSublist(T,NEWPOSITION,M,N,R).         

% main predicate which calls the above predicate with POSITION=0

sublist(L,M,N,R):-
    createSublist(L,0,M,N,R).

% tests for sublist predicate

testSublistAll:-
    sublist([],2,6,[]),
    sublist([1,2,3,4,5,6,7,8],0,4,[1,2,3,4,5]),
    sublist([1,2,3,4,5,6,7,8],10,14,[]),
    sublist([1,2,3,4,5,6,7,8],6,9,[7,8]).

testSublist(L,M,N,R):-
    sublist(L,M,N,R).

% for the console tests:
% testSublist([],2,6,R). -> R = []                           % empty list
% testSublist([1,2,3,4,5,6,7,8],0,4,R). -> R = [1,2,3,4,5]   % substring exists
% testSublist([1,2,3,4,5,6,7,8],10,14,R). -> R = []          % substring does not exist
% testSublist([1,2,3,4,5,6,7,8],6,9,R). -> R = [7,8]         % substring exists
