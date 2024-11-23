(defun unique (xs &optional (ys '()))
  (if (null xs)
      ys
      (if (member (car xs) ys)
          (unique (cdr xs) ys)
          (unique (cdr xs) (cons (car xs) ys)))))

(defun calc-res (n a b &aux (s '()))
  (dotimes (i n (sort (unique s) #'<))
    (push (+ (* i a) (* (- n i) b)) s)
    (push (+ (* b i) (* (- n i) a)) s)))

(defun calc-cases ()
  (let ((results '()))
    (dotimes (i (read) (reverse results))
      (setf results (cons (calc-res (1- (read)) (read) (read)) results)))))

(defun main (args)
  (declare (ignore args))
  (dolist (r (calc-cases))
    (dolist (i r)
      (format t "~A " i))
    (format t "~%")))


;; (main)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defun gen-permutations (elements num-perm-elements)
;;   (do ((perm-stack '())
;;        (result-stack '()))
;;       ((and (null perm-stack) (not (null result-stack))) result-stack)
;;     (let ((c (pop perm-stack))
;;           (r '()))
;;       (dolist (e elements)
;;         (setf r (cons e c))
;;         (if (= (length r) num-perm-elements)
;;             (push r result-stack)
;;             (push r perm-stack))))))

;; (defun gen-sums (elements num-perm-elements)
;;   (do ((perm-stack '())
;;        (result-stack '()))
;;       ((and (null perm-stack) (not (null result-stack))) result-stack)
;;     (let ((c (pop perm-stack))
;;           (r '()))
;;       (dolist (e elements)
;;         (setf r (cons e c))
;;         (if (= (length r) num-perm-elements)
;;             (push (apply #'+ r) result-stack)
;;             (push r perm-stack))))))

;; (defun gen-sums-no-perm (elements num-perm-elements)
;;   (do ((perm-stack '())
;;        (result-stack '()))
;;       ((and (null perm-stack) (not (null result-stack))) result-stack)
;;     (let ((c (pop perm-stack))
;;           (r '()))
;;       (dolist (e elements)
;;         (if c
;;             (setf r (list (1+ (car c)) (+ e (cadr c))))
;;             (setf r (list 1 e)))
;;         (if (= (car r) num-perm-elements)
;;             (if (not (member (cadr r) result-stack))
;;                 (push (cadr r) result-stack))
;;             (push r perm-stack))))))
;; (defun calc (n a b)
;;   (sort
;;    ;;(unique
;;     ;;(mapcar (lambda (c) (apply #'+ c))
;;              (gen-sums-no-perm (list a b) (1- n)) #'<))


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
