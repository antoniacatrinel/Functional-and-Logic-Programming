; Define a function that replaces one node with another one in a n-tree represented as:  
; (root list_of_nodes_subtree1... list_of_nodes_subtreen) 
; Eg: tree is (a (b (c)) (d) (e (f))) and node 'b' will be replaced with node 'g' => tree (a (g (c)) (d) (e (f)))

; Mathematical model:
; replace-element(l1l2...ln, old-elem, new-elem) = new-elem, if l is atom and l1l2...ln = {old-elem}
;                                                  l1l2...ln, if l is atom and l1l2...ln != {old-elem}
;                                                  replace-element(l1, old-elem, new-elem) U replace-element(l2, old-elem, new-elem) U .... U replace-element(ln, old-elem, new-elem), otherwise (l is list)

(defun replace-element(l old-elem new-elem)
    (cond
        ((and (atom l) (eq l old-elem)) 
            new-elem)
        ((atom l)
            l)
        ((listp l)  ; or t
            (mapcar #'(lambda (a) (replace-element a old-elem new-elem)) l))
    )
)

; change: both elements are modified

(defun replace-element2(l old-elem new-elem)
    (cond
        ((and (atom l) (eq l old-elem)) 
            new-elem)
        ((and (atom l) (eq l new-elem)) 
            old-elem)
        ((atom l) 
            l)
        ((listp l)  ; or t
            (mapcar #'(lambda (a) (replace-element2 a old-elem new-elem)) l))
    )
)

; tests

(defun test-replace()
    (assert (
        and
		(equal (replace-element '() 'a 'b) '())
		(equal (replace-element '(a (b (c)) (d) (e (f))) 'b 'g) '(a (g (c)) (d) (e (f))))
		(equal (replace-element '(a (b (c)) (d) (e (f))) 'j 'g) '(a (b (c)) (d) (e (f))))
		(equal (replace-element '(a (b) (c (d))) 'd 'r) '(a (b) (c (r))))
		(equal (replace-element '(a) 'b 'm) '(a))
        (equal (replace-element '(a) 'a 'm) '(m))
        (equal (replace-element '(a (b (c (i)) (f (g))) (d (e) (h))) 'f 'q) '(a (b (c (i)) (q (g))) (d (e) (h))))
        (equal (replace-element '(a (b) (c (d) (e))) 'e 'w) '(a (b) (c (d) (w))))
        (equal (replace-element '(1 (2) (3 (4) (5))) '5 '6) '(1 (2) (3 (4) (6))))
	)
	)
)

(defun test-replace2()
    (assert (
        and
		(equal (replace-element2 '() 'a 'b) '())
		(equal (replace-element2 '(a (b (c)) (d) (e (f))) 'b 'a) '(b(a (c)) (d) (e (f))))
		(equal (replace-element2 '(a (b (c)) (d) (e (f))) 'e 'f) '(a (b (c)) (d) (f (e))))
		(equal (replace-element2 '(a (b) (c (d))) 'd 'a) '(d (b) (c (a))))
		(equal (replace-element2 '(a) 'b 'm) '(a))
        (equal (replace-element2 '(a) 'a 'm) '(m))
        (equal (replace-element2 '(a (b (c (i)) (f (g))) (d (e) (h))) 'f 'i) '(a (b (c (f)) (i (g))) (d (e) (h))))
        (equal (replace-element2 '(a (b) (c (d) (e))) 'e 'c) '(a (b) (e (d) (c))))
        (equal (replace-element2 '(1 (2) (3 (4) (5))) '5 '3) '(1 (2) (5 (4) (3))))
	)
	)
)

; open folter in wsl
; console: new terminal
; clisp
; (load "replaceTreeNode.lisp")
; (replace-element '(1 (2) (3 (4) (5))) '5 '3)
