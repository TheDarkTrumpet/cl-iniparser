; ln -s /home/.../asd_file /usr/local/lib/sbcl/site-systems (Ubuntu)-- will be needed for this to work.
;                          /usr/lib/sbcl/site-systems (Gentoo)

(in-package #:cl-user)

(asdf:defsystem :ini-parser
  :components ((:file "ini-parser"))
  :depends-on (:cl-ppcre))