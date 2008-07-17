
;;;; font settings
(cond ((fboundp 'global-font-lock-mode)
       (global-font-lock-mode t)
       (setq font-lock-maximum-decoration t)))

(transient-mark-mode t)

(if (memq window-system '(win32 w32))
  (set-default-font "-*-Bitstream Vera Sans Mono-normal-r-*-*-12-*-*-*-c-*-iso8859-1")
  (set-default-font "lucidasanstypewriter-10"))

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
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/python-mode-1.0")
(add-to-list 'load-path "~/.emacs.d/clojure-mode")

;;; clojure mode
(require 'clojure-mode-config)

;;;; python mode
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
                                   interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

;;;; restructured text
(require 'rst)
(defun my-rst-mode-common-hook ()
  (setq tab-width 2))
;(add-hook 'text-mode-hook 'rst-text-mode-bindings)
(add-hook 'text-mode-hook 'my-rst-mode-common-hook)

;;; Hacks for jit-lock-mode
;(setq rst-mode-lazy nil)
(setq jit-lock-context-time 5)
(setq jit-lock-defer-time .5)
(setq jit-lock-stealth-time 10)
(setq jit-lock-stealth-verbose nil)
(setq jit-lock-stealth-nice 0.5)
(setq jit-lock-stealth-load 10)
(setq jit-lock-chunk-size 50)

;;;; unicode character handling
(set-language-environment "UTF-8")
(load "~/.emacs.d/unichars")
(load "~/.emacs.d/xmlunicode")
(global-set-key "\C-cu" 'unicode-character-insert)
(global-set-key "\C-c\"" 'unicode-smart-double-quote)
(global-set-key "\C-c'" 'unicode-smart-single-quote)

;;;; nxml mode
(load "~/.emacs.d/nxml-mode/rng-auto.el")
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

