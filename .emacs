
;;;; font settings
(cond ((fboundp 'global-font-lock-mode)
       (global-font-lock-mode t)
       (setq font-lock-maximum-decoration t)))

(transient-mark-mode t)

(if (memq window-system '(win32 w32))
    (progn
      (set-default-font "-*-Bitstream Vera Sans Mono-normal-r-*-*-12-*-*-*-c-*-iso8859-1")
      (setq inferior-lisp-program "C:/lisp/SBCL/1.0.6/sbcl.exe"))
  (progn
    (set-default-font "lucidasanstypewriter-10")
    (setq inferior-lisp-program "sbcl")))

;;;; personal packages
(add-to-list 'load-path "~/src/lisp-site")
(add-to-list 'load-path "~/src/lisp-site/python-mode-1.0")


;;;; slime
;(setq inferior-lisp-program
;      (concat "C:/clisp/full/lisp.exe -B C:/clisp/full/ "
;              "-M C:/clisp/full/lispinit.mem -i C:/home/.clisprc -ansi -q"))
(add-to-list 'load-path "~/src/lisp-site/slime")
(require 'slime)
(slime-setup)

(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))

(slime-autodoc-mode)

;;;; python mode
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
				   interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

;;;; paredit
;(autoload 'paredit-mode "paredit"
;          "Minor mode for pseudo-structurally editing Lisp code."
;          t)
;(add-hook 'scheme-mode-hook (lambda () (paredit-mode +1)))
;(add-hook 'lisp-mode-hook (lambda () (paredit-mode +1)))

;;;; restructured text
(require 'rst)
(add-hook 'text-mode-hook 'rst-text-mode-bindings)

;;;; unicode character handling
(set-language-environment "UTF-8")
(load "~/src/lisp-site/unichars")
(load "~/src/lisp-site/xmlunicode")
(global-set-key "\C-cu" 'unicode-character-insert)
(global-set-key "\C-c\"" 'unicode-smart-double-quote)
(global-set-key "\C-c'" 'unicode-smart-single-quote)

;;;; vimpulse
;(setq viper-mode t)
;(setq viper-ex-style-editing nil)
;(require 'viper)
;(require 'vimpulse)
;(setq woman-use-own-frame nil)
;(setq woman-use-topic-at-point t)
;(require 'redo)

