(defun get-permutations (elem-kinds num-elements elements &aux (xs (make-list 1)))
    (if (zerop num-elements)
        elements
        (dolist (k elem-kinds (cdr xs))
          (setf xs (concatenate 'list xs
                 (get-permutations elem-kinds
                       (1- num-elements)
                       (cons k elements)))))))

(defun get-perms (elem-kinds num-elements elements &aux (xs (list 0)))
    (if (zerop num-elements)
        elements
        (dolist (k elem-kinds (cdr xs))
          (nconc xs
                 (get-perms elem-kinds
                       (1- num-elements)
                       (cons k elements))))))

(defun chunks (ls n xs &aux (ts '(nil)))
  (if (null ls) (return-from chunks (cdr xs)))
  (dotimes (_ n)
    (setf ts (cons (car ls) ts))
    (setf ls (cdr ls)))
  (nconc xs (list (cdr (reverse ts))))
  (chunks ls n xs))

(defun reverse-chunks (ls n xs &aux (ts '()))
  (if (null ls) (return-from reverse-chunks (cdr xs)))
  (dotimes (_ n)
    (setf ts (cons (car ls) ts))
    (setf ls (cdr ls)))
  (nconc xs (list ts))
  (reverse-chunks ls n xs))

(defun unique (xs ys)
  (if (null xs)
      (reverse ys)
      (if (member (car xs) ys)
          (unique (cdr xs) ys)
          (progn (setf ys (cons (car xs) ys)) (unique (cdr xs) ys)))))

;; (sort
;;  (unique
;;   (mapcar #'car
;;           (reverse-chunks
;;            (get-permutations '(2 3) 3 '()) 3 '(0))) ()) #'<)
