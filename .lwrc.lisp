
;;;;;;;;;;;;;;;;;;;;;;;
;;; From lw-add-ons ;;;
;;;;;;;;;;;;;;;;;;;;;;;

;;; -*- Mode: LISP; Syntax: COMMON-LISP; Package: CL-USER; Base: 10 -*-
;;; $Header: /usr/local/cvsrep/lw-add-ons/.lispworks,v 1.23 2007/12/20 02:34:03 edi Exp $

;;; Copyright (c) 2005-2007, Dr. Edmund Weitz.  All rights reserved.

;;; Redistribution and use in source and binary forms, with or without
;;; modification, are permitted provided that the following conditions
;;; are met:

;;;   * Redistributions of source code must retain the above copyright
;;;     notice, this list of conditions and the following disclaimer.

;;;   * Redistributions in binary form must reproduce the above
;;;     copyright notice, this list of conditions and the following
;;;     disclaimer in the documentation and/or other materials
;;;     provided with the distribution.

;;; THIS SOFTWARE IS PROVIDED BY THE AUTHOR 'AS IS' AND ANY EXPRESSED
;;; OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
;;; WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;;; ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
;;; DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
;;; DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
;;; GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;;; INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
;;; WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
;;; NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
;;; SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

(in-package :cl-user)

#+(and :lispworks5 :win32)
(win32:dismiss-splash-screen t)

#+:win32
;; to "fix" USER-HOMEDIR-PATHNAME
;; see <http://support.microsoft.com/default.aspx?scid=kb;en-us;101507>
(setf (lw:environment-variable "HOMEPATH") "\\home"
      (lw:environment-variable "HOMEDRIVE") "C:")

(defvar *asdf-pathname* (merge-pathnames #P"lisp/asdf" (user-homedir-pathname))
  "Where ASDF can be found.  This pathname should not have a type.")

(defvar *asdf-base-dirs* (list
                           (merge-pathnames #P"lisp/packages/" (user-homedir-pathname)))
  "A list of directories \(note trailing slashes) which contain
directories that contain ASDF system definitions.

Example: If you have, say, c:/home/lisp/cl-ppcre/cl-ppcre.asd and
c:/home/lisp/tbnl/tbnl.asd, then \"c:/home/lisp/\" should be in
this list, and NOT \"c:/home/lisp/cl-ppcre/\".")

(defvar *working-dir* (merge-pathnames #P"src/" (user-homedir-pathname))
  "The working directory LW is supposed to switch to after loading
this initialization file.")


;; loads (and compiles, if needed) ASDF unless it's already in the
;; image
#-:asdf
(handler-case
  (when *asdf-pathname*
    (load (or (compile-file-if-needed *asdf-pathname*)
              *asdf-pathname*)))
  (conditions:fasl-error ()
    (load (compile-file *asdf-pathname*))))

(defun walk-directory-for-asdf (dir)
  "Looks into the directory DIR and all subdirectories and adds all
directories which contain files of type \"asd\" to
ASDF:*CENTRAL-REGISTRY*."
  (dolist (dir-candidate (directory (lw:pathname-location dir)))
    (when (lw:file-directory-p dir-candidate)
      (walk-directory-for-asdf dir-candidate)
      (let ((asd-candidate (merge-pathnames "*.asd" dir-candidate)))
        (when (directory asd-candidate)
          (pushnew dir-candidate asdf:*central-registry* :test #'equal))))))

(defun update-asdf-central-registry ()
  "Loops through *ASDF-BASE-DIRS* recursively and adds all
directories containing system definitions to ASDF's central
registry."
  (dolist (base-dir *asdf-base-dirs*)
    (walk-directory-for-asdf base-dir)))

(update-asdf-central-registry)

(defmethod asdf:perform :around ((o asdf:load-op) (c asdf:cl-source-file))
  "When trying to load a Lisp source file with ASDF that has a wrong
FASL version recompiles it."
  ;; from Bill Clementson's blog
  (handler-case
    (call-next-method o c)
    (conditions:fasl-error ()
      (asdf:perform (make-instance 'asdf:compile-op) c)
      (call-next-method))))

(defun asdf (lib)
  "Shortcut for ASDF."
  (asdf:oos 'asdf:load-op lib))

;; `canonical' indentation for IF
(editor:setup-indent "if" 1 2 4)

;; `canonical' indentation for FLI:DEFINE-FOREIGN-FUNCALLABLE
;; (not needed for LW 5.0)
(editor:setup-indent "define-foreign-funcallable" 2 2 4)

;; `canonical' indentation for DEFINE-SYMBOL-MACRO
(editor:setup-indent "define-symbol-macro" 1)

;; file types for Lisp mode
(editor:define-file-type-hook 
    ("lispworks" "lisp" "lsp" "cl" "asd")
    (buffer type)
  (declare (ignore type))
  (setf (editor:buffer-major-mode buffer) "Lisp"))

;; the following two forms make sure the "Find Source" command works
;; with the editor source
#-:lispworks-personal-edition
(load-logical-pathname-translations "EDITOR-SRC")

#-:lispworks-personal-edition
(setf dspec:*active-finders*
        (append dspec:*active-finders*
                (list "EDITOR-SRC:editor-tags-db")))

;; if I press ESC followed by < during a search operation I want to go
;; to the beginning of the buffer and /not/ insert the #\< character
(editor::set-logical-char= #\escape :exit nil
                           (editor::editor-input-style-logical-characters
                            editor::*emacs-input-style*))

(change-directory *working-dir*)

(asdf :lw-add-ons)

#+(and :win32 (not :console-image))
(define-action "Initialize LispWorks Tools" "Open Editor And Tile Windows"
               'lw-add-ons::open-editor-and-tile-windows-vertically)

;;; some key bindings

(editor:bind-key "Insert Space and Show Arglist" #\Space)

(editor:bind-key "Compile Defun" '#(#\control-\c #\control-\c) :mode "Lisp")
(editor:bind-key "Compile and Load Buffer File" '#(#\control-\c #\control-\k) :mode "Lisp")

(editor:bind-key "Tools Apropos" '#(#\control-\c #\control-\a))

(editor:bind-key "Toggle Trace" '#(#\control-\c #\control-\t) :mode "Lisp")

(editor:bind-key "Evaluate Last Form And Inspect" '#(#\control-\c #\control-\i))
(editor:bind-key "Evaluate Last Form And Describe" '#(#\control-\c #\control-\d))

(editor:bind-key "Set Mark And Highlight" #\control-\@)
(editor:bind-key "Set Mark And Highlight" #\control-space)

(editor:bind-key "Indent and Complete Symbol" '#\Tab)

(editor:bind-key "Meta Documentation" "F5")

(editor:bind-key "Insert \()" #\control-\( :mode "Lisp")
(editor:bind-key "Insert \()" #\control-\( :mode "Execute")

(editor:bind-key "Indent New Line" #\Return :mode "Lisp")

(editor:bind-key "Pop Definitions Stack" #\control-\Backspace)

(editor:bind-key "Maybe Invoke Listener Shortcut" #\, :mode "Execute")

(editor:bind-key "Tools Listener" "F12")
(editor:bind-key "Tools Editor" "F11")

; vim: set filetype=lisp:
