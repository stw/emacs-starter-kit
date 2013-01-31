;; (server-start) 

;; clojure
(add-to-list 'load-path "~/.emacs.d/plugins/clojure-mode")
(require 'clojure-mode)
(require 'nrepl)
(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
(setq nrepl-popup-stacktraces nil)

;;(autoload 'python-mode "after-load/python" "" t)
;;(require "after-load/python")

;; ace-jump-mode
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; expand region
(add-to-list 'load-path "~/.emacs.d/plugins/expand-region")
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; openwith 
(require 'openwith) 
(setq openwith-associations '(("\\.pdf\\'" "open" (file))))
(openwith-mode t)

;; command logging
;; (add-hook 'rinari-mode-hook (function mwe:log-keyboard-commands))
(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)


(require 'dired-x) 
(setq dired-omit-files 
      (rx (or (seq bol (? ".") "#")         ;; emacs autosave files 
              (seq bol "." (not (any "."))) ;; dot-files 
              (seq "~" eol)                 ;; backup-files 
              (seq bol "CVS" eol)           ;; CVS dirs 
              ))) 
(setq dired-omit-extensions 
      (append dired-latex-unclean-extensions 
              dired-bibtex-unclean-extensions 
              dired-texinfo-unclean-extensions)) 
(add-hook 'dired-mode-hook (lambda () (dired-omit-mode 1))) 
;; use M-o to toggle mode

;;(add-to-list 'load-path "~/.emacs.d/plugins/slime") 
(add-to-list 'load-path "~/.emacs.d/plugins/swank-clojure") 
(require 'slime)
(slime-setup '(slime-repl slime-fancy))
(setq slime-lisp-implementations
      '((sbcl ("/usr/local/bin/sbcl"))
     (clojure ("/Users/steve/bin/clojure") :init swank-clojure-init))) 
(add-to-list 'auto-mode-alist '("\\.lisp" . slime-mode)) 
       (add-to-list 'auto-mode-alist '("\\.lisp" . lisp-mode))

;; coffee-mode
(add-to-list 'load-path "~/.emacs.d/plugins/coffee-mode")
(require 'coffee-mode)

;; configure HTML editing
(require 'php-mode)
                                   
;;(add-to-list 'load-path "~/.emacs.d/plugins/javascript-mode")
;;(require 'javascript-mode) 
(require 'psgml) 
(setq sgml-auto-activate-dtd t)
(setq sgml-indent-data t) 

;; configure css-mode
(autoload 'css-mode "css-mode")
(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))
(setq cssm-indent-function #'cssm-c-style-indenter)
(setq cssm-indent-level '2)

;;
(add-hook 'php-mode-user-hook 'turn-on-font-lock)

;; (defun web-mode-hook ()
;;   (whitespace-mode))

(add-hook 'html-mode-hook 'web-mode-hook)
(add-hook 'php-mode-hook 'web-mode-hook)
(add-hook 'ruby-mode-hook 'web-mode-hook)

;; Toggle between PHP & HTML Helper mode.  Useful when working on
;; php files, that can been intertwined with HTML code
(defun toggle-php-html-mode ()
  (interactive)
  "Toggle mode between PHP & HTML Helper modes"
  (cond ((string= mode-name "HTML helper")
         (php-mode))
        ((string= mode-name "PHP")
         (html-helper-mode))))

(global-set-key [f5] 'toggle-php-html-mode)

;; (require 'tidy)
;; (autoload 'tidy-buffer "tidy" "Run Tidy HTML parser on current buffer" t)
;; (autoload 'tidy-parse-config-file "tidy" "Parse the `tidy-config-file'" t)
;; (autoload 'tidy-save-settings "tidy" "Save settings to `tidy-config-file'" t)
;; (autoload 'tidy-build-menu  "tidy" "Install an options menu for HTML Tidy." t)
;; (defun my-html-mode-hook () "Customize my html-mode."
;;    (tidy-build-menu)
;;    (local-set-key [(control c) (control c)] 'tidy-buffer)
;;    (setq sgml-validate-command "tidy")
;;    )

(add-hook 'html-mode-hook 'my-html-mode-hook)

;;(autoload #'espresso-mode "espresso" "Start espresso-mode" t)
;; try js2-mode
(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))

;; bookmark+
(add-to-list 'load-path "~/.emacs.d/plugins/bookmark+") 
(require 'bookmark+)

;; fix yas to work w/ ruby
(defun yas/advise-indent-function (function-symbol)
  (eval `(defadvice ,function-symbol (around yas/try-expand-first activate)
           ,(format
             "Try to expand a snippet before point, then call `%s' as usual"
             function-symbol)
           (let ((yas/fallback-behavior nil))
             (unless (and (interactive-p)
                          (yas/expand))
               ad-do-it)))))

(yas/advise-indent-function 'ruby-indent-line)
(yas/advise-indent-function 'indent-and-complete)

(add-hook 'ruby-mode-hook (lambda ()
                            (whitespace-mode)))

;; ecb setup
;;(add-to-list 'load-path "~/.emacs.d/ecb")
;;(load-file "~/.emacs.d/ecb/ecb.el")
;;(require 'ecb)
;;(global-set-key "\C-c\C-w" 'ecb-activate)
;;(global-set-key "\C-c\C-q" 'ecb-deactivate)
;;(require 'ecb-autoloads)

;; key maps
;; already defined in aquamacs (global-set-key "\C-w" 'backward-kill-word)
(global-set-key (kbd "C-c s") 'vi-dw)
(global-set-key (kbd "C-x q") 'swap-quotes)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
(global-set-key "\C-c\C-v" 'browse-url)

;;(global-set-key "\C-l" 'goto-line)

;; these don't work with textmate.el?
;;(define-key osx-key-mode-map (kbd "A-]") 'previous-buffer)
;;(define-key osx-key-mode-map (kbd "A-[") 'next-buffer)
(global-set-key (kbd "M-{") 'previous-buffer)
(global-set-key (kbd "M-}") 'next-buffer)
(global-set-key (kbd "C-c u") 'pop-global-mark)

;; dynamic abbreviations
(global-set-key (kbd "C-<tab>") 'dabbrev-expand)
(define-key minibuffer-local-map (kbd "C-<tab>") 'dabbrev-expand)

;; Allow narrowing - restrict edits to page, region or defun
(put 'narrow-to-defun 'disabled nil)     
(put 'narrow-to-page 'disabled nil)     
(put 'narrow-to-region 'disabled nil)
  
(defalias 'qrr 'query-replace-regexp)

;;(set-face-attribute 'default nil :family "Monaco" :height 140 :weight 'normal)
;;(set-face-attribute 'font-lock-string-face nil :family "Monaco" :height 140)

;; set tabs
(setq indent-tabs-mode nil)
(setq c-basic-offset 2)
(setq js-indent-level 2)
(setq tab-width 2)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq python-indent 2)

;; github
;; (setq gist-view-gist t)

;; rails setup
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/emacs-rails"))
(require 'rails)

;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/rinari"))
;;(require 'rinari)

(add-to-list 'auto-mode-alist '("\\.scss$" . sass-mode))
(global-set-key "\C-c\C-m" 'magit-status)

;; Install mode-compile to give friendlier compiling support!
;;(autoload 'mode-compile "mode-compile"
;;   "Command to compile current buffer file based on the major mode" t)
;;(global-set-key "\C-cc" 'mode-compile)
;;(autoload 'mode-compile-kill "mode-compile"
;; "Command to kill a compilation launched by `mode-compile'" t)
;;(global-set-key "\C-ck" 'mode-compile-kill)

;;(defun eshell-banner-message "")
(setq explicit-shell-file-name "/bin/bash")
(display-time)

;;(ecb-activate)
;;(split-window-vertically)

(defun backward-up-sexp (arg)
    (interactive "p")
      (let ((ppss (syntax-ppss)))
            (cond ((elt ppss 3)
                              (goto-char (elt ppss 8))
                                         (backward-up-sexp (1- arg)))
                            ((backward-up-list arg)))))

(global-set-key [remap backward-up-list] 'backward-up-sexp) 

;; textmate 
(add-to-list 'load-path "~/.emacs.d/plugins/textmate")
(require 'textmate)
;;(textmate-mode) 

;; evernote mode 
;;(setq evernote-ruby-command "/Users/steve/.rvm/rubies/ruby-1.9.2-p290/bin/ruby")
;;(require 'evernote-mode)
;;(setq evernote-username "steveaz98") ; optional: you can use this username as default.
;;(setq evernote-enml-formatter-command '("w3m" "-dump" "-I" "UTF8" "-O" "UTF8")) ; option
;;(global-set-key "\C-c ec" 'evernote-create-note)
;;(global-set-key "\C-c eo" 'evernote-open-note)
;;(global-set-key "\C-c es" 'evernote-search-notes)
;;(global-set-key "\C-c eS" 'evernote-do-saved-search)
;;(global-set-key "\C-c ew" 'evernote-write-note)
;;(global-set-key "\C-c ep" 'evernote-post-region)
;;(global-set-key "\C-c eb" 'evernote-browser)

(global-set-key (kbd "C-c d") (kbd "M-0 C-k"))

(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))

(add-hook 'octave-mode-hook
                    (lambda ()
                      (abbrev-mode 1)
                      (auto-fill-mode 1)
                      (if (eq window-system 'x)
                          (font-lock-mode 1))))

(defvar hexcolour-keywords
  '(("#[abcdef[:digit:]]\\{6\\}"
     (0 (put-text-property
         (match-beginning 0)
         (match-end 0)
         'face (list :background 
                     (match-string-no-properties 0)))))))
(defun hexcolour-add-to-font-lock ()
  (font-lock-add-keywords nil hexcolour-keywords))

(add-hook 'css-mode-hook 'hexcolour-add-to-font-lock)

;; byte compile any lisp file on save
;;
;; (add-hook 'emacs-lisp-mode-hook '(lambda ()
;;   (add-hook 'after-save-hook 'emacs- lisp-byte-compile t t)))

(setq stack-trace-on-error t)

;; http://git.naquadah.org/git/google-weather-el.git
(add-to-list 'load-path "~/.emacs.d/plugins/google-weather")
(require 'google-weather)
(require 'org-google-weather)

;; colors and fonts
(add-to-list 'load-path "~/.emacs.d/steve/color-theme")
(require 'color-theme)
(color-theme-initialize)
(setq color-theme-is-global t)
;;(setq dark-or-light 'dark)
(color-theme-stw-dark)
