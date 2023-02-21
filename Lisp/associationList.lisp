; Write a function to return an association list with the two lists given as parameters.
; Example: (A B C) (X Y Z) --> ((A.X) (B.Y) (C.Z)).

; appends a list to another list
; Mathematical model:
; append-to-list(l1l2...ln, p1p2...pm) = p1p2...pm, if n = 0
;                                        {l1} U append-to-list(l2l3...ln, p1p2...pm), otherwise

(defun append-to-list(l p)
    (cond
        ((null l) 
            p)
        (t 
            (cons (car l) (append-to-list (cdr l) p)))
    )
)

; Mathematical model:
; association(l1l2...ln, p1p2...pm) = nil, if n = 0 and m = 0
;                                     append-to-list(association(nil, p2p3...pm), list({nil} U {p1})), if n = 0
;                                     append-to-list(association(l2l3...ln, nil), list({l1} U {nil})), if m = 0
;                                     append-to-list(association(l2l3...ln, p2p3...pm), list({l1} U {p1})), otherwise

(defun association(l p)
    (cond
        ((and (null l) (null p)) 
            nil)
        ((null l) 
            (append-to-list (list (cons nil (car p))) (association nil (cdr p))))
        ((null p) 
            (append-to-list (list (cons (car l) nil)) (association (cdr l) nil)))
        (t 
            (append-to-list (list (cons (car l) (car p))) (association (cdr l) (cdr p))))
    )
)

; tests

(defun test-association()
    (assert (
        and
        (equal (association '() '()) '())
        (equal (association '(A B C) '(X Y Z)) '((A . X) (B . Y) (C . Z)))
        (equal (association '() '(A B)) '((NIL . A) (NIL . B)))
        (equal (association '(C D) '()) '((C) (D)))
        (equal (association '(C D) '(A B)) '((C . A) (D . B)))
        (equal (association '(C D E) '(A B)) '((C . A) (D . B) (E)))
        (equal (association '(C D E) '(A B J I)) '((C . A) (D . B) (E . J) (NIL . I)))
    )
    )
)

; open folter in wsl
; console: new terminal
; clisp
; (load "associationList.lisp")
; (association '(C D E) '(A B J I))
