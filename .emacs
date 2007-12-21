
;;;; font settings
(cond ((fboundp 'global-font-lock-mode)
       (global-font-lock-mode t)
       (setq font-lock-maximum-decoration t)))

(transient-mark-mode t)

(if (memq window-system '(win32 w32))
    (progn
      (set-default-font "-*-Bitstream Vera Sans Mono-normal-r-*-*-12-*-*-*-c-*-iso8859-1")
      (setq slime-lisp-implementations
            '((sbcl ("C:/lisp/SBCL/1.0.12/sbcl.exe"))
              (clisp ("C:/lisp/clisp-2.41/clisp.exe"))))
      ;(setq inferior-lisp-program "C:/lisp/SBCL/1.0.12/sbcl.exe")
      )
    (progn
      (set-default-font "lucidasanstypewriter-10")
      (setq slime-lisp-implementations
            '((sbcl ("sbcl"))))))

;;;; indent only with spaces. death to tabs!
(setq-default indent-tabs-mode nil)

;;;; personal packages
(add-to-list 'load-path "~/src/lisp-site")
(add-to-list 'load-path "~/src/lisp-site/python-mode-1.0")
(add-to-list 'load-path "~/src/lisp-site/erlang")
(add-to-list 'load-path "~/src/lisp-site/redshank")

;;;; slime
(add-to-list 'load-path "~/src/lisp-site/slime")
(require 'slime)
(slime-setup)

(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))

(slime-autodoc-mode)

;;;; scheme mode
(setf scheme-program-name "mzscheme")

;;;; python mode
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
				   interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

;;;; erlang mode
(if (memq window-system '(win32 w32))
  (progn
    (setq erlang-root-dir "C:/erlang/erl5.5.5")
    (setq exec-path (cons "C:/erlang/erl5.5.5/bin" exec-path)))
  (setq erlang-root-dir "/usr/local"))
(require 'erlang-start)

;;;; paredit
(autoload 'paredit-mode "paredit"
          "Minor mode for pseudo-structurally editing Lisp code."
          t)
(add-hook 'scheme-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook (lambda () (paredit-mode +1)))

;;;; redshank
(autoload 'redshank-mode "redshank"
          "Mintor mode for editing and refactoring (Common) Lisp code."
          t)
(add-hook 'lisp-mode-hook (lambda () (redshank-mode +1)))

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

;;;; nxml mode
(load "~/src/lisp-site/nxml-mode/rng-auto.el")
(setq auto-mode-alist
      (cons '("\\.\\(xml\\|xsl\\|rng\\|xhtml\\)\\'" . nxml-mode)
            auto-mode-alist))

;;;; C# mode
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist
      (append '(("\.cs$" . csharp-mode)) auto-mode-alist))

;; C/C++/Java/C# Mode
;; (from http://mfgames.com/linux/docs/csharp-mode)
(defun my-c-mode-common-hook ()
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'statement-cont 4)
  (c-set-offset 'topmost-intro-cont 0)
  (c-set-offset 'block-open 0)
  (c-set-offset 'arglist-intro 4)
  (c-set-offset 'arglist-cont-nonempty 4)
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(defun my-csharp-mode-hook ()
  (progn
    (turn-on-font-lock)
    (auto-fill-mode)
    (setq tab-width 4)
    (define-key csharp-mode-map "\t" 'c-tab-indent-or-complete)))
(add-hook 'csharp-mode-hook 'my-csharp-mode-hook)
