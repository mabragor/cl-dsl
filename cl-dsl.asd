;;;; cl-dsl.asd

(asdf:defsystem #:cl-dsl
  :serial t
  :version "0.1"
  :description "Easily define domain specific languages"
  :author "Alexander Popolitov <popolit@gmail.com>"
  :license "GPL"
  :components ((:file "package")
               (:file "cl-dsl")))

(defsystem :cl-dsl-tests
  :description "Tests for CL-DSL."
  :licence "GPL"
  :depends-on (:cl-dsl :eos)
  :components ((:file "tests")))

(defmethod perform ((op test-op) (sys (eql (find-system :cl-dsl))))
  (load-system :cl-dsl-tests)
  (funcall (intern "RUN-TESTS" :cl-dsl-tests)))

