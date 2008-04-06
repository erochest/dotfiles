
;;;; font settings
(cond ((fboundp 'global-font-lock-mode)
       (global-font-lock-mode t)
       (setq font-lock-maximum-decoration t)))

(transient-mark-mode t)

(if (memq window-system '(win32 w32))
    (progn
      (set-default-font "-*-Bitstream Vera Sans Mono-normal-r-*-*-12-*-*-*-c-*-iso8859-1")
      (setq slime-lisp-implementations
            '((clisp ("C:/Documents and Settings/Eric/clisp-2.41/clisp.exe"))))
                                        ;(setq inferior-lisp-program "C:/lisp/SBCL/1.0.12/sbcl.exe")
      )
  (progn
    (set-default-font "lucidasanstypewriter-10")
    (setq slime-lisp-implementations
          '((sbcl ("sbcl"))))))

;;;; don't always move the middle of the screen when scrolling off the
;;;; bottom or top of the screen
(setq-default scroll-step 2)

;;;; show the current column
(column-number-mode t)

;;;; turn off sound
(setq visible-bell t)

;;;; always match parens
(show-paren-mode)

;;;; indent only with spaces. death to tabs!
(setq-default indent-tabs-mode nil)

;;;; personal packages
(add-to-list 'load-path "~/lisp")
(add-to-list 'load-path "~/lisp/python-mode-1.0")
(add-to-list 'load-path "~/lisp/erlang")
(add-to-list 'load-path "~/lisp/redshank")
;(add-to-list 'load-path "~/lisp/color-theme")
(add-to-list 'load-path "~/lisp/yasnippet")

;;;; clojure
(add-to-list 'load-path "~/lisp/clojure-emacs/clojure-mode")

(require 'clojure-mode)
(setq auto-mode-alist (cons '("\\.clj$" . clojure-mode) auto-mode-alist))
(add-hook 'clojure-mode-hook
          '(lambda ()
             (define-key clojure-mode-map "\C-c\C-e" 'lisp-eval-last-sexp)
             (define-key clojure-mode-map "\C-x\C-e" 'lisp-eval-last-sexp)))

(setq inferior-lisp-program
      (let* ((win32 (memq window-system '(win32 w32)))
             (java-path "java")
             (java-options "")
             (clojure-path (if win32
                               "C:\\Java\\clojure\\target\\"
                             "~/java/clojure/target/"))
             (class-path-delimiter (if win32 ";" ":"))
             (class-path (mapconcat (lambda (s) s)
                                    ; Add other paths to this list
                                    ; if you want to have other
                                    ; things in your classpath.
                                    (list (concat
                                           clojure-path
                                           "clojure-lang-1.0-SNAPSHOT.jar"))
                                    class-path-delimiter)))
        (concat java-path
                " " java-options
                " -cp " class-path
                " clojure.lang.Repl")))

;;;; slime
(add-to-list 'load-path "~/lisp/slime")
(require 'slime)
(slime-setup)

(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))

;;;; scheme mode
(require 'quack)
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
(defun my-rst-mode-common-hook ()
  (setq tab-width 2))
;(add-hook 'text-mode-hook 'rst-text-mode-bindings)
(add-hook 'text-mode-hook 'my-rst-mode-common-hook)

;;;; unicode character handling
(set-language-environment "UTF-8")
(load "~/lisp/unichars")
(load "~/lisp/xmlunicode")
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
(load "~/lisp/nxml-mode/rng-auto.el")
(setq auto-mode-alist
      (cons '("\\.\\(xml\\|xsl\\|rng\\|xhtml\\)\\'" . nxml-mode)
            auto-mode-alist))

;;;; C# mode
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist
      (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))

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

;;; Tuareg mode for Caml (and F#)
(setq auto-mode-alist (cons '("\\.ml\\w?" . tuareg-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.fs\\w?" . tuareg-mode) auto-mode-alist))
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)

;; This modifies the mode for F#
(defadvice tuareg-find-alternate-file (around fsharp-find-alternate-file)
  "Switch Implementation/Interface."
  (interactive)
  (let ((name (buffer-file-name)))
    (if (string-match "\\`\\(.*\\)\\.fs\\(i\\)?\\'" name)
        (find-file (concat (tuareg-match-string 1 name)
                           (if (match-beginning 2) ".fs" ".fsi"))))))

(defconst tuareg-error-regeaxp-fs
  "^\\([^(\n]+\\)(\\([0-9]+\a\),\\([0-9]+\\)):"
  "Regular expression matching the error messages produced by fsc.")

(add-hook 'tuareg-mode-hook
          '(lambda ()
             (ad-activate 'tuareg-find-alternate-file)
             (setq tuareg-interactive-program "fsi")
             (if (boundp 'compilation-error-regexp-alist)
                 (or (assoc tuareg-error-regexp-fs
                            compilation-error-regexp-alist)
                     (setq compilation-error-regexp-alist
                           (cons (list tuareg-error-regexp-fs 1 2 3)
                                 compilation-error-regexp-alist))))))

;;; Fortune system from http://bc.tech.coop/blog/071226.html

;; Initialize the random number algo
(random t)

(defvar fortune-file "~/.fortune.txt"
  "The file that fortunes come from.")

(defvar fortune-strings nil
  "The fortunes in the fortune file.")

(defun open-fortune-file (file)
  (find-file file)
  (if (null fortune-strings)
      (let ((strings nil)
	    (prev 1))
	(goto-char (point-min))
	(while (re-search-forward "^%$" (point-max) t)
	  (push (buffer-substring-no-properties prev (- (point) 1))
		strings)
	  (setq prev (1+ (point))))
	(push (buffer-substring-no-properties prev (point-max)) strings)
	(setq fortune-strings (apply 'vector strings)))))

(defun fortune ()
  "Get a fortune to display."
  (interactive)
  (when (null fortune-strings)
    (open-fortune-file fortune-file)
    (kill-buffer (current-buffer)))
  (let* ((n (random (length fortune-strings)))
	 (string (aref fortune-strings n)))
    (if (interactive-p)
	(message (format "%s" string))
      string)))

;; Override standard startup message
(defun startup-echo-area-message ()
  (fortune))

;;; yasnippet
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/lisp/yasnippet/snippets")

;;; added js2 mode
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(setq js2-basic-offset 2)
(setq js2-use-font-lock-faces t)

;;; Color Themes
;(require 'color-theme)
;(load "~/lisp/color-theme/themes/color-theme-library.el")
;(color-theme-charcoal-black)
