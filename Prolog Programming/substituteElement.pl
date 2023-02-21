% Write a predicate to substitute an element from a list with another element in the list.

/* Mathematical model:
l1l2...ln - initial list
e1 - element to be substituted
e2 - new element

substituteElement(l1l2...ln, e1, e2) = [],  if l1l2...ln = [] (n = 0)
                                     = {e2} U substituteElement(l2...ln, e1, e2), if l1 = e1 (element to be substituted is the head of the list)
                                     = {l1} U substituteElement(l2...ln, e1, e2), otherwise                                     
*/

% substituteElement(L:list, E1:number, E2:number, R:list)
% flow model (i, i, i, o), (i, i, i, i)
                                             
substituteElement([],_,_,[]).                 
substituteElement([H|T],E1,E2,[E2|R]):-      
    H=:=E1,                                   
    substituteElement(T,E1,E2,R).            
substituteElement([H|T],E1,E2,[H|R]):-       
    H=\=E1,                                  
    substituteElement(T,E1,E2,R).

isMember([X|_], X).
isMember([_|T], X):-
    isMember(T, X).

% main predicate

mainSubstitute(L,E1,E2,R):-
    ( isMember(L, E2)
    -> substituteElement(L,E1,E2,R)
    ; R = L
    ).

% tests for substituteElement predicate

testSubstituteAll:-
    mainSubstitute([],2,6,[]),
    mainSubstitute([1,2,3,4,5],7,6,[1,2,3,4,5]),
    mainSubstitute([1,2,3,4,5],2,6,[1,2,3,4,5]),
    mainSubstitute([6,7,8,9,10],10,6,[6,7,8,9,6]).

testSubstituteElement(L,E1,E2,R):-
    substituteElement(L,E1,E2,R).

% for the console tests:
% testSubstituteElement([],2,6,R). -> R = []                       % empty list
% testSubstituteElement([1,2,3,4,5],7,6,R). -> R = [1,2,3,4,5]     % element does not exist
% testSubstituteElement([1,2,3,4,5],2,6,R). -> R = [1,6,3,4,5]     % correct substitution
% testSubstituteElement([6,7,8,9,10],10,6,R). -> R = [6,7,8,9,6]   % correct substitution
