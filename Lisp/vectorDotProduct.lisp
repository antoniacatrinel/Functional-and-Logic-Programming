; Write a function to return the product of two vectors. https://en.wikipedia.org/wiki/Dot_product

; Mathematical model:
; dot-product(l1l2...ln, k1k2...km) = 0 , if n = 0
;                                   = l1*l2 + dot-product(l2...ln, k2...km) , otherwise

(defun dot-product (l k)
    (cond
        ((null l) 
            0)
        (T
            (+ (* (car l) (car k)) (dot-product (cdr l) (cdr k))))
    )
)

; tests

(defun test-dot-product()
    (assert (
        and
        (equal (dot-product '(1 2 3) '(4 5 6)) '(4 10 18))
        (equal (dot-product '(10 5 6 9 2) '(1 2 4 5 6)) '(10 10 24 45 12))
        )
    )
)

; open folter in wsl
; console: new terminal
; clisp
; (load "vectorDotProduct.lisp")
; (dot-product '(1 2 3) '(4 5 6))