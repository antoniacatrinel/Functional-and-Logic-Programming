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

; Convert a tree of type (1) to type (2).

; Mathematical model:
; s1s2...sn = subtree - list of nodes starting with the first node of the left subtree
; result = list, collector variable
; nrNodes = number of nodes we need to parse
; returns the part of the list of type 1 which bellongs to the left subtree

; left-subtree(s1s2...sn, r1r2...rm, nrNodes) = r1r2...rm, if nrNodes = 1
;												r1r2...rm + s1s2...sn, if n = 2 and nrNodes = 2
;												left-subtree(s3...sn, r1r2...rm + {s1} U {s2}, nrNodes + s2 - 1), otherwise

; cddr s1s2...sn = cdr (cdr s1s2...sn) = cdr s2s3..sn = s3...sn
; cadr s1s2...sn = car (cdr s1s2...sn) = car s2s3..sn = s2

(defun left-subtree (subtree result nrNodes)
	(cond
		; if the initial list has only 2 elements and we have 2 nodes left to parse, we concatenate the result with the initial list (subtree)
		((and (= (length subtree) 2) (= nrNodes 2)) 
			(append result subtree))
		; if we are left with only 1 node, we return the result
		(( = nrNodes 1) 
			result) 
		(t 
			(left-subtree (cddr subtree) (append result (list (car subtree)) (list (cadr subtree))) (- (+ nrNodes (cadr subtree)) 1)))
	)
)

; Mathematical model:
; s1s2...sn = subtree - list of nodes starting with the first node of the right subtree
; nrNodes = number of nodes we need to parse
; returns the part of the list of type 1 which bellongs to the right subtree

; right-subtree(s1s2...sn, nrNodes) = s1s2...sn, if n = 2 or nrNodes = 1
;									  right-subtree(s3...sn, nrNodes + s2 - 1), otherwise

; cddr s1s2...sn = cdr (cdr s1s2...sn) = cdr s2s3..sn = s3...sn
; cadr s1s2...sn = car (cdr s1s2...sn) = car s2s3..sn = s2

(defun right-subtree (subtree nrNodes)
	(cond
		; if the initial list has only 2 elements or we have 2 nodes left to parse, we return the result
		(( or (= (length subtree) 2) ( = nrNodes 1)) 
			subtree)
		(t	
			(right-subtree (cddr subtree) (- (+ nrNodes (cadr subtree)) 1)))
	)
)

; (a 2 b 2 c 1 i 0 f 1 g 0 d 2 e 0 h 0)
; (A (B (C (I) ) (F (G) ) ) (D (E) (H) ) )

; b 2 c 1 i 0 f 1 g 0 d 2 e 0 h 0
; c 1 i 0 f 1 g 0 d 2 e 0 h 0,     b 2,    2 - 1 + 2 = 3
; i 0 f 1 g 0 d 2 e 0 h 0,         b 2 c 1,     3 - 1 + 1  = 3
; f 1 g 0 d 2 e 0 h 0              b 2 c 1 i 0,  3 - 1 + 0 = 2

; Mathematical model:
; tree = list representing a binary tree
; converts the binary tree from type 1 to type 2
; convert(t1t2...tn) = nil, if n = 0 (list is empty)
;					   {t1}, if n = 2 (we only have 1 node left to parse)
;                      {t1}, if t2 = 0 (current node has no children)
;                      {t1} + convert(left-subtree(t3...tn, [], 2)), if t2 = 1
;                      {t1} + convert(left-subtree(t3...tn, [], 2)) + convert(right-subtree(t3...tn, 2)), if t2 = 2

; cddr s1s2...sn = cdr (cdr s1s2...sn) = cdr s2s3..sn = s3...sn
; cadr s1s2...sn = car (cdr s1s2...sn) = car s2s3..sn = s2

(defun convert (tree)
	(cond
		; if the tree is empty from the beginning, return nil
		((= (length tree) 0) 
			nil)
		; the last 2 elements will be an atom and number 0, because it cannot have subtrees, so return a list with only that atom
		((= (length tree) 2) 
			(list (car tree)))
		; when the curent atom has no subtree, return a list which contains it
		; the elements on even positions is the number of subtrees of the current atom -> cadr tree
		(( = (cadr tree) 0) 
			(list (car tree)))
		; when the curent atom has one subtree, return a list which contains it and the result of convert (left_subtree)
		(( = (cadr tree) 1) 
			(list (car tree) (convert (left-subtree (cddr tree) () '2))))
		; when the curent atom has 2 subtrees, return a list which contains it, the result of convert (left_subtree) and the result of convert (right_subtree)
		(( = (cadr tree) 2) 
			(list (car tree) (convert (left-subtree (cddr tree) () '2)) (convert (right-subtree (cddr tree) '2))))
	)
)

; tests

(defun test-convert()
	(assert (
        and
		(equal (convert '()) '())
		(equal (convert '(A 2 B 0 C 2 D 0 E 0)) '(A (B) (C (D) (E))))
		(equal (convert '(A 2 B 0 C 1 D 0)) '(A (B) (C (D))))
		(equal (convert '(A 1 B 0)) '(A (B)))
		(equal (convert '(A 0)) '(A))
		(equal (convert '(A 2 B 2 C 1 I 0 F 1 G 0 D 2 E 0 H 0)) '(A (B (C (I)) (F (G))) (D (E) (H))))
	)
	)
)

; open folter in wsl
; console: new terminal
; clisp
; (load "convertBinaryTree.lisp")
; (convert '(A 2 B 2 C 1 I 0 F 1 G 0 D 2 E 0 H 0))
