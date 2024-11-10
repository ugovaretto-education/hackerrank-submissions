;; Read input
;; (defun parse-string-to-num (line)
;;   (with-input-from-string (s line)
;;     (loop
;;       for num := (read s nil nil)
;;       while num
;;       collect num)))

(defun chars-to-nums (chars)
  (loop for i across chars
        for num := (digit-char-p i)
        collect num))

(defun read-input ()
  (loop
    for line := (read-line *standard-input*  nil nil)
    while (and line (not (zerop (length line))))
    collect line))

(defun list-to-2d-array (xs)
  (make-array (list (length xs)
                    (length (first xs)))
              :element-type 'integer
              :initial-contents xs))

(defun neighbors (v row col &aux
                              (max-height (1- (array-dimension v 0)))
                              (max-width (1- (array-dimension v 1))))
  (let ((north (max (1- row) 0))
        (south (min (1+ row) max-height))
        (east (max (1- col) 0))
        (west (min (1+ col) max-width)))
    (list
     (aref v north col)
     (aref v row east)
     (aref v south col)
     (aref v row west))))

(defun make-char-array (rows cols)
  (make-array (list rows cols) :initial-element #\Space))

(defun mark-array (m &aux
                       (height (array-dimension m 0))
                       (width (array-dimension m 1))
                       (out (make-char-array height width)))
  (dotimes (row height)
    (dotimes (col width)
      (let ((e (aref m row col)))
        (if (< (reduce #'max (neighbors m row col)) e)
            (setf (aref out row col) #\X)
            (setf (aref out row col) (digit-char e))))))
    out)

(defun print-array-2d (m &aux
                           (height (array-dimension m 0))
                           (width (array-dimension m 1)))
  ;;(format t "~&~%")
  (dotimes (row height)
    (dotimes (col width)
      (format t "~A" (aref m row col)))
    (format t "~%")))

(defun main ()
  (let ((m (list-to-2d-array (mapcar #'chars-to-nums (cdr (read-input))))))
    (print-array-2d (mark-array m))))

(main)
