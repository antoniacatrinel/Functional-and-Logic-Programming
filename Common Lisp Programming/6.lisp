; Write twice the n-th element of a linear list. 
; Example: for (10 20 30 40 50) and n = 3 will produce (10 20 30 30 40 50).

; Mathematical model:
; pos = current index in the list
; twice-nth-element(l1l2...lm, n, pos) = nil, if m = 0 (list is empty)
;                                        {l1} U {l1} U twice-nth-element(l2l3...lm, n, pos + 1), if n = pos
;                                        {l1} U twice-nth-element(l2l3...lm, n, pos + 1), otherwise

(defun twice-nth-element(l n pos)
    (cond
        ((null l) 
            nil)
        ((equal n pos) 
            (cons (car l) (cons (car l) (twice-nth-element (cdr l) n (+ 1 pos)))))
        (t 
            (cons (car l) (twice-nth-element (cdr l) n (+ 1 pos))))
    )
)

; Mathematical model:
; main-twice(l1l2..lm, n) = twice-nth-element(l1l2...lm, n, 1)

(defun main-twice(l n)
    (twice-nth-element l n 1)
)


; computes the length of a list
; length-list(l1l2....ln) = 0, if n = 0
;                           1 + length-list(l1l2...ln), otherwise

(defun length-list(l)
     (cond
        ((null l) 
            0)
        (t 
            (+ 1 (length-list (cdr l))))
    )
)

; Write twice the n-th element from the end of a linear list.

; Mathematical model:
; pos = current index in the list
; twice-nth-element-from-end(l1l2...lm, n, pos) = nil, if m = 0 (list is empty)
;                                                 {l1} U {l1} U twice-nth-element-from-end(l2l3...lm, n, pos + 1), if n = length(l) - pos + 1
;                                                 {l1} U twice-nth-element-from-end(l2l3...lm, n, pos + 1), otherwise

(defun twice-nth-element-from-end(l len n pos)
    (cond
        ((null l) 
            nil)
        ((equal n (+ (- len pos) 1)) 
            (cons (car l) (cons (car l) (twice-nth-element-from-end (cdr l) len n (+ 1 pos)))))
        (t 
            (cons (car l) (twice-nth-element-from-end (cdr l) len n (+ 1 pos))))
    )
)

(defun main-twice-end(l n)
    (twice-nth-element-from-end l (length-list l) n 1)
)

; tests

(defun test-twice()
    (assert (
        and
        (equal (main-twice '() 3) '())
        (equal (main-twice '(1 2 3 4 5) 9) '(1 2 3 4 5))
        (equal (main-twice '(10 20 30 40 50) 3) '(10 20 30 30 40 50))
        (equal (main-twice '(17 18 19 20) 0) '(17 18 19 20))
        (equal (main-twice '(88 77 66 99 22 44) 1) '(88 88 77 66 99 22 44))
        )
    )
)

(defun test-twice-end()
    (assert (
        and
        (equal (main-twice-end '() 3) '())
        (equal (main-twice-end '(1 2 3 4 5) 9) '(1 2 3 4 5))
        (equal (main-twice-end '(10 20 30 40) 2) '(10 20 30 30 40))
        (equal (main-twice-end '(17 18 19 20) 4) '(17 17 18 19 20))
        )
    )
)

; open folter in wsl
; console: new terminal
; clisp
; (load "duplicateNthElement.lisp")
; (mainTwice '(10 20 30 40 50) 3)
