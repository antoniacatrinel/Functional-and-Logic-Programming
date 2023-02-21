; Replace each sublist of a list with its last element.

(defun my-append (l1 l2)
    (cond
        ((null l1)
            l2)
        (T 
            (cons (car l1) (my-append (cdr l1) l2)))
    )
)

(defun my-reverse (l)
    (cond
        ((null l)
            nil)
        (T
            (my-append (my-reverse (cdr l)) (list (car l))))
    )
)

(defun get-last-element (l)
    (cond
        ((listp l)
            (get-last-element (car (my-reverse l))))
        (T
            l)
    )
)

; replace-last-element(l1l2...ln) = nil , if n = 0
;                                 = get-last-element(l1) U replace-last-element(l2...ln), if l1 is a list
;                                 = {l1} U replace-last-element(l2...ln), otherwise

(defun replace-last-element (l)
    (cond
        ((null l)
            nil)
        ((listp (car l))
            (cons (get-last-element (car l)) (replace-last-element (cdr l))))
        (T
            (cons (car l) (replace-last-element (cdr l))))
    )
)

(defun test ()
    (assert
        (and
            (equal (replace-last-element '(A (B ((C ))) (D (E (F))))) '(A C F))
            (equal (replace-last-element '(A B C D E)) '(A B C D E))
            (equal (replace-last-element '(A (B C) (D E F) (G H))) '(A C F H))
            (equal (replace-last-element '(A (B (C (D) E)) F (G) H (I J (K)))) '(A E F G H K))
        )
    )
)

; open folter in wsl
; console: new terminal
; clisp
; (load "replaceSublists.lisp")
; (replace-last-element '(A (B (C (D) E)) F (G) H (I J (K))))