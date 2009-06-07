; To run:
; (require 'ini)
; (in-package :ini-parser-test)
; (ini-parser-test "/path/to/test/cfg")

(eval-when (:compile-toplevel :load-toplevel 
			      :execute) (require :ini-parser))

(defpackage :ini-parser-test
  (:use :ini-parser))

(in-package :ini-parser)

; Below are helper-methods for the tests to ensure the parse is working correctly
(defun test-iterHash (hashtbl)
  (maphash #'(lambda (k v) (cond
			     ((hash-table-p v)
			      (format t "Hash Table Encountered: ~a~%" k)
			      (test-iterHash v))
			     (t (format t "~a => ~a~%" k v))))
	   hashtbl))

(defun ini-parser-test (file)
  (let ((a (make-instance 'iniParser :file-name file)))
    (parse-file a)
    (format t "Hash Contents...~%")
    (test-iterhash (slot-value a 'contents))))