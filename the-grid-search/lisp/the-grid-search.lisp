(defun chars-to-nums (chars)
  (loop for i across chars
        for num := (digit-char-p i)
        collect num))

(defun read-grid (num-lines &aux (grid '()))
  (dotimes (_ num-lines (reverse grid))
    (push (chars-to-nums (read-line)) grid )))


(defun print-array-2d (m &aux
                           (height (array-dimension m 0))
                           (width (array-dimension m 1)))
  ;;(format t "~&~%")
  (dotimes (row height)
    (dotimes (col width)
      (format t "~A" (aref m row col)))
    (format t "~%")))


(defun pattern-match (grid pattern)
  (print-array-2d grid)
  (format t  "~%")
  (print-array-2d pattern)
  (let ((row-end (1+ (- (array-dimension grid 0) (array-dimension pattern 0))))
        (col-end (1+ (- (array-dimension grid 1) (array-dimension pattern 1))))
        (pattern-rows (array-dimension pattern 0))
        (pattern-cols (array-dimension pattern 1)))
    (format t "~&row-end: ~A col-end: ~A pattern-rows: ~A pattern-cols: ~A~%"
            row-end col-end pattern-rows pattern-cols)
    (dotimes (row row-end nil) ;; return false if it reaches the end
      (dotimes (col col-end)
        (if
         (block match-pattern ;; exits block if pattern does not match
           (dotimes (r pattern-rows t) ;; return true if it reaches the end
                                       ;; i.e. all elements match
            (dotimes (c pattern-cols)
              (let ((g (aref grid (+ row r) (+ col c)))
                    (p (aref pattern r c)))
                (if (not (= g p)) (return-from match-pattern nil)
                    ())))))
         (return-from pattern-match t))))));; return true if pattern matches

(defun main (args)
  (declare (ignore args))
  (dotimes (_ (read))
    (let* ((grid-size (list (read) (read)))
           (grid (read-grid (car grid-size)))
           (pattern-size (list (read) (read)))
           (pattern (read-grid (car pattern-size))))
      (if
       (pattern-match
        (make-array grid-size :initial-contents grid)
        (make-array pattern-size :initial-contents pattern))
       (format t "~&YES")
       (format t "~&NO")))))

;;(main)
