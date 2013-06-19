;;;; cl-dsl.lisp

;;; This is part of CL-DSL package, see COPYING for details on usage.

(in-package #:cl-dsl)

(defun with-macrolets (would-be-macrolets body)
  `(macrolet ,(mapcar (lambda (x)
			`(,(intern (string x)) (&rest args) `(,',x ,@args)))
		      would-be-macrolets)
     ,@body))

(defun with-flets (would-be-flets body)
  `(flet ,(mapcar (lambda (x)
		    `(,(intern (string x)) (&rest args) `(,',x ,@args)))
		  would-be-flets)
     ,@body))
  
