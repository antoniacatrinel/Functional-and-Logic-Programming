; Compute the depth of a non-linear list.

; depth-list(l1l2...ln, d) = d, if n = 0
;                          = depth-list(l2...ln, d), if l1 is atom
;                          = my-max(depth-list(l1, d+1), depth-list(l2l3...ln, d)), if l1 is list

(defun depth-list (l d)
  (cond
    ((null l) 
        d)
    ((listp (car l)) 
        (my-max (depth-list (car l) (+ d 1)) (depth-list (cdr l) d)))
    (t 
        (depth-list (cdr l) d))
  )
)

; my-max(a, b) = 
; = a , if a > b
; = b ,  otherwise

(defun my-max (a b)
  (cond
    ((> a b) a)
    (t b)
  )
)

; main(l1l2...ln) = 
; = depth-list(l1l2...ln, 1)

(defun main_depth (l)
  (cond
    (t (depth-list l 1))
  )
)

; tests

(defun test-depth()
    (assert (
        and
        (equal (main_depth '(6 (2 3 (4) (5) (6 (7))))) '4)
        (equal (main_depth '(6 (2 3 (4) (5) (6 7)))) '3)
        )
    )
)

; open folter in wsl
; console: new terminal
; clisp
; (load "depthList.lisp")
; (main_depth '(6 (2 3 (4) (5) (6 (7)))))
