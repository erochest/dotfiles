
(load (compile-file (merge-pathnames #P"lisp/asdf.lisp" (user-homedir-pathname))))

#+win32
(progn
  ;;; Code i've added to automatically find the package directories and add
  ;;; them to the central registry.
  ;;; This works with clisp, at least.
  (defun add-all-packages (base-dir)
    (dolist (asd-file (directory (merge-pathnames #P"*/*.asd" base-dir)))
      (pushnew (make-pathname :directory (pathname-directory asd-file))
               asdf:*central-registry*
               :test #'equal)))
  (add-all-packages (merge-pathnames #P"lisp/packages/" (user-homedir-pathname))))

#-win32
(pushnew (merge-pathnames #P"lisp/systems/" (user-homedir-pathname))
         asdf:*central-registry*
         :test #'equal)

; vim: set filetype=lisp:
