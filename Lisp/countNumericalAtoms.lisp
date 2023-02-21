; Write a function to return the number of all numerical atoms in a list at superficial level.

; Mathematical model:
; count-numerical-atoms(l1l2...ln) = 0, if n = 0
;                                    1 + count-numerical-atoms(l2l3...ln), if l1 is number
;                                    count-numerical-atoms(l2l3...ln), otherwise

(defun count-numerical-atoms(l)
    (cond
        ((null l) 
            0)
        ((numberp (car l)) 
            (+ 1 (count-numerical-atoms (cdr l))))
        (t 
            (count-numerical-atoms (cdr l)))
    )
)

; tests

(defun test-numerical-atoms()
    (assert (
        and
        (equal (count-numerical-atoms '()) 0)
        (equal (count-numerical-atoms '(7 9 1 2)) 4)
        (equal (count-numerical-atoms '(2 3 (1 2 3) 3 4 5 ())) 5)
        (equal (count-numerical-atoms '(2 3 (1 2 3) 3 4 5 () (12 3 4 5) 1 2 3)) 8)
        (equal (count-numerical-atoms '(1 2 () (7 6 (10 9)))) 2)
    )
    )
)

; open folter in wsl
; console: new terminal
; clisp
; (load "countNumericalAtoms.lisp")
; (count-numerical-atoms '(1 2 () (7 6 (10 9))))
