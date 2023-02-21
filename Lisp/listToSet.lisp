; Transform a linear list into a set.

; Mathematical model:
; remove-occurences(l1l2...ln, e) = nil, if n = 0
;                                 = remove-occurences(l2l3...ln), if l1 = e
;                                 = {l1} U remove-occurences(l2l3...ln), otherwise

(defun remove-occurences (l e)
    (cond
        ((null l)
            nil)
        ((= (car l) e)
            (remove-occurences (cdr l) e))
        (T
            (cons (car l) (remove-occurences (cdr l) e)))
    )
)

; transform-set(l1l2...ln) = nil , if n = 0
;                          = {l1} U transform-set(remove-occurences(l2...ln, l1)) , otherwise

(defun transform-set (l)
    (cond
        ((null l)
            nil)
        (T
            (cons (car l) (transform-set (remove-occurences (cdr l) (car l)))))
    )
)

; tests

(defun test-set()
    (assert (
        and
        (equal (transform-set '(1 2 3 44 2 4 5 2 3 3 3 3 4 4 5 77)) '(1 2 3 44 4 5 77))
        (equal (transform-set '(1 0 0 0 0 1)) '(1 0))
        )
    )
)

; open folter in wsl
; console: new terminal
; clisp
; (load "listToSet.lisp")
; (transform-set '(1 2 3 44 2 4 5 2 3 3 3 3 4 4 5 77))
