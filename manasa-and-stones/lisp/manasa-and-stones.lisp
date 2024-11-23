(defun gen-permutations (elements num-perm-elements)
  (do ((perm-stack '())
       (result-stack '()))
      ((and (null perm-stack) (not (null result-stack))) result-stack)
    (let ((c (pop perm-stack))
          (r '()))
      (dolist (e elements)
        (setf r (cons e c))
        (if (= (length r) num-perm-elements)
            (push r result-stack)
            (push r perm-stack))))))


(defun unique (xs &optional (ys '()))
  (if (null xs)
      ys
      (if (member (car xs) ys)
          (unique (cdr xs) ys)
          (unique (cdr xs) (cons (car xs) ys)))))

(defun calc (n a b)
  (sort
   (unique
    (mapcar (lambda (c) (apply #'+ c))
             (gen-permutations (list a b) (1- n)))) #'<))

(defun calc-cases ()
  (let ((results '()))
    (dotimes (i (read) (reverse results))
      (setf results (cons (calc (read) (read) (read)) results)))))

(defun main (args)
  (declare (ignore args))
  (dolist (r (calc-cases))
    (dolist (i r)
      (format t "~A " i))
    (format t "~%")))

;; (main)

;; (defun gen-permutations (elem-kinds num-elements elements &aux (xs '(0)))
;;     (if (zerop num-elements)
;;         elements
;;         (dolist (k elem-kinds (cdr xs))
;;           (setf xs (concatenate 'list xs
;;                  (gen-permutations elem-kinds
;;                        (- num-elements 1)
;;                        (cons k elements)))))))


;; (defun chunks (ls n xs)
;;   (if (null ls) (return-from chunks xs)
;;       (let ((ts '()))
;;         (dotimes (_ n)
;;           (setf ts (cons (car ls) ts))
;;           (setf ls (cdr ls)))
;;         (chunks ls n (cons ts xs)))))



;; (defun get-perms (elem-kinds num-elements elements &aux (xs (list 0)))
;;     (if (zerop num-elements)
;;         elements
;;         (dolist (k elem-kinds (cdr xs))
;;           (nconc xs
;;                  (get-perms elem-kinds
;;                        (1- num-elements)
;;                        (cons k elements))))))

;; (defun chunks (ls n xs &aux (ts '(nil)))
;;   (if (null ls) (return-from chunks (cdr xs)))
;;   (dotimes (_ n)
;;     (setf ts (cons (car ls) ts))
;;     (setf ls (cdr ls)))
;;   (nconc xs (list (cdr (reverse ts))))
;;   (chunks ls n xs))
