; Write a function to determine the number of all sublists of a given list, on any level. 
; A sublist is either the list itself, or any element that is a list, at any level. 
; Example: (1 2 (3 (4 5) (6 7)) 8 (9 10)) => 5 lists:(list itself, (3 ...), (4 5), (6 7), (9 10)).

; Mathematical model:
; count-sublists(l1l2...ln) = 1, if n = 0
;                             count-sublists(l1) + count-sublists(l2l3...ln), if l1 is list  -> in order to go at any level in the list
;                             count-sublists(l2l3...ln), otherwise

(defun count-sublists(l)
    (cond
        ((null l) 
            1)
        ((listp (car l)) 
            (+ (count-sublists (car l)) (count-sublists (cdr l))))
        (t 
            (count-sublists (cdr l)))
    )
)

; tests

(defun test-sublists()
    (assert (
        and
        (equal (count-sublists '()) 1)
        (equal (count-sublists '(1 2 (3 (4 5) (6 7)) 8 (9 10))) 5)
        (equal (count-sublists '(7 8 () (1 2 (10 12 14) (18 20 24)) (14) 26 8)) 6)
        (equal (count-sublists '(() () () (() ()))) 7)
        (equal (count-sublists '(1 2 () (7 6 (10 9)))) 4)
    )
    )
)

; open folter in wsl
; console: new terminal
; clisp
; (load "countSublistsAnyLevel.lisp")
; (count-sublists '(1 2 () (7 6 (10 9))))
