;;; This is part of CL-DSL package, see COPYING for details on usage

(in-package #:cl)

(defpackage #:cl-dsl-test-1
  (:use #:cl #:cl-dsl)
  (:export #:main-macro))

(in-package #:cl-dsl-test-1)

(defmacro foo (x)
  (format nil "~a" x))

(defun bar (x)
  (format nil "~a" x))

(defmacro main-macro (&body body)
  (with-macrolets '(foo bar) body))

(defpackage #:cl-dsl-tests
  (:use #:cl #:cl-dsl-test-1 #:eos)
  (:export #:run-tests))

(in-package cl-dsl-tests)

(def-suite dsl)
(in-suite dsl)

(defun run-tests ()
  (let ((results (run 'dsl)))
    (eos:explain! results)
    (unless (eos:results-status results)
      (error "Tests failed."))))

(test simple-dsl
      (is (equal "123"
		 (main-macro (foo 123))))
      (is (equal "456"
		 (main-macro (bar 456))))
      (signals (error "use of FOO without MAIN-MACRO didn't signal an error.")
	       (foo 123)))
