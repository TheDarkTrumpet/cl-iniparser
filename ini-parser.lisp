; To run:
; (require 'ini-parser)
; (in-package :ini-parser)

(defpackage :ini-parser
  (:use :cl :cl-ppcre))

(in-package :ini-parser)

(defclass iniParser ()
  ((file
    :initarg :file-name
    :initform NIL
    :accessor :config-file)
   (contents
    :initform (make-hash-table)
    :reader :contents)))

(defgeneric parse-file (iniParser))

(defmethod parse-file ((iniobj iniParser))
  (let ((newheader nil))
    (with-slots (file contents) iniobj
      (with-open-file (stream file)
	(loop for line = (read-line stream nil)
	   while line do (register-groups-bind (header key val) ("\\[(\\w*)\\]|(\\w*)\\s*=\\s*([\\w\\W]*)" line)
			   (cond ((eql header nil)
				  (setf (gethash key (gethash newheader contents)) val))
				 ((not (eql header newheader))
				  (setf newheader header)
				  (setf (gethash header contents) (make-hash-table))
				  ))))))))

