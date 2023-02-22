; A binary tree is memorised in the following two ways:
; (1) (node no-subtrees list-subtree-1 list-subtree-2 ...)
; (2) (node (list-subtree-1) (list-subtree-2) ...)

; As an example, the tree 
;      A
;     / \
;     B  C
;       / \
;       D  E
; is represented as follows: (1) (A 2 B 0 C 2 D 0 E 0)
;                            (2) (A (B) (C (D) (E)))
; For a given tree of type (2) return the path from the root node to a certain given node X.

(defun is-member (l e)
    (cond 
        ((null l) nil)
        ((equal (car l) e) t )
        (t (or (is-member (cadr l) e) (is-member (caddr l) e)))
    )
)

(defun path (l e)
    (cond
        ((not (is-member l e)) nil)
        ((equal (car l) e)(list  e) )
        ((is-member (cadr l) e) (cons (car l) (path (cadr l) e)))
        (t (cons (car l) (path (caddr l) e)))
    )
)    

(defun path-to-node (l e)    
    (cond
        ((null l) nil)
        ((equal (car l) e) (list e))
        (t 
         ((lambda (l e x y)
                 (cond
                     ((and (null x) (null y)) nil)
                     (t (cons (car l) (append x y)))
                 ))
                 l e (path-to-node (cadr l) e) (path-to-node (caddr l) e))

        )
    )
)

; tests

(defun test-path-to-node()
    (assert (
        and
        (equal (path-to-node '(A (B) (C (D) (E))) 'D) '(A C D))
         (equal (path-to-node '(A (B) (C (D (F (G))) (E))) 'G) '(A C D F G))
        )
    )
)

; open folter in wsl
; console: new terminal
; clisp
; (load "pathToNode.lisp")
; (path-to-node '(A (B) (C (D) (E))) 'D)
