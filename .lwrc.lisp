
(load (compile-file (merge-pathnames #P"lisp/asdf.lisp" (user-homedir-pathname))))

;;; Code i've added to automatically find the package directories and add
;;; them to the central registry.
;;; This works with clisp, at least.
(defun add-all-packages (base-dir)
  (dolist (asd-file (directory (merge-pathnames #P"*/*.asd" base-dir)))
    (pushnew (make-pathname :directory (pathname-directory asd-file))
             asdf:*central-registry*
             :test #'equal)))

(add-all-packages (merge-pathnames #P"lisp/packages/" (user-homedir-pathname)))

; vim: set filetype=lisp:
