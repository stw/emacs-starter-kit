;; command logging
;; (add-hook 'rinari-mode-hook (function mwe:log-keyboard-commands))
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

(require 'slime)
(add-to-list 'load-path "~/.emacs.d/steve/slime") 
(add-to-list 'load-path "~/.emacs.d/steve/swank-clojure") 
(slime-setup '(slime-repl slime-fancy))
(setq slime-lisp-implementations
      '((sbcl ("/usr/local/bin/sbcl"))
     (clojure ("/Users/steve/bin/clojure") :init swank-clojure-init))) 
(add-to-list 'auto-mode-alist '("\\.lisp" . slime-mode)) 
(add-to-list 'auto-mode-alist '("\\.lisp" . lisp-mode))
;; coffee-mode
(add-to-list 'load-path "~/.emacs.d/coffee-mode")
(require 'coffee-mode)

;;(require 'multi-web-mode)
;;(setq mweb-default-major-mode 'html-mode)
;;(setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
;;                  (js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
;;                  (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
;;(setq mweb-filename-extensions '("inc", "php" "htm" "html" "ctp" "phtml" "php4" "php5"))
;;(multi-web-global-mode 1)

;;(add-to-list 'load-path "~/.emacs.d/js2-mode")
;;(require 'js2-mode)
;;(autoload 'js2-mode "js2-mode" nil t)
;;(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;;************************************************************
;; configure HTML editing
;;************************************************************
;;
(require 'php-mode)
(require 'javascript-mode) 

(require 'psgml) 
(setq sgml-auto-activate-dtd t)
(setq sgml-indent-data t) 

;;
;; configure css-mode
(autoload 'css-mode "css-mode")
(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))
(setq cssm-indent-function #'cssm-c-style-indenter)
(setq cssm-indent-level '2)
;;
(add-hook 'php-mode-user-hook 'turn-on-font-lock)
;;
(require 'mmm-mode)
(setq mmm-global-mode 'maybe)
;;
;; set up an mmm group for fancy html editing
(mmm-add-group
 'fancy-html
 '(
         (html-php-tagged
                :submode php-mode
                :face mmm-code-submode-face
                :front "<[?]php"
                :back "[?]>")
         (html-css-attribute
                :submode css-mode
                :face mmm-declaration-submode-face
                :front "style=\""
                :back "\"")))
;;
;; What files to invoke the new html-mode for?
(add-to-list 'auto-mode-alist '("\\.inc\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.php[34]?\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.[sj]?html?\\'" . html-mode))
;;
;; What features should be turned on in this html-mode?
(add-to-list 'mmm-mode-ext-classes-alist '(html-mode nil html-js))
(add-to-list 'mmm-mode-ext-classes-alist '(html-mode nil embedded-css))
(add-to-list 'mmm-mode-ext-classes-alist '(html-mode nil fancy-html))
;;
;; Not exactly related to editing HTML: enable editing help with mouse-3 in all sgml files
(defun go-bind-markup-menu-to-mouse3 ()
        (define-key sgml-mode-map [(down-mouse-3)] 'sgml-tags-menu))
;;
(add-hook 'sgml-mode-hook 'go-bind-markup-menu-to-mouse3)
(setq sgml-warn-about-undefined-entities nil)
(setq mmm-submode-decoration-level 0)

(add-hook 'html-mode-hook
       (lambda ()
        (require 'php-align)
        (php-align-setup)))

(defun save-mmm-c-locals ()
  (with-temp-buffer
    (php-mode)
    (dolist (v (buffer-local-variables))
      (when (string-match "\\`c-" (symbol-name (car v)))
        (add-to-list 'mmm-save-local-variables `(,(car v) nil ,mmm-c-derived-modes))))))
(save-mmm-c-locals)


(autoload #'espresso-mode "espresso" "Start espresso-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))

;; bookmark+
(add-to-list 'load-path "~/.emacs.d/bookmark+") 
(require 'bookmark+)

;; bbdb
;;(add-to-list 'load-path "~/.emacs.d/bbdb")
;;(require 'bbdb)
;;(bbdb-initialize)

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

;; gnus
;;(setq load-path (cons (expand-file-name "~/src/emacs/gnus/lisp") load-path))
;;(require 'gnus-load)

;; terminal colors
;;(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
;;(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; ecb setup
;;(add-to-list 'load-path "~/.emacs.d/ecb")
;;(load-file "~/.emacs.d/ecb/ecb.el")
;;(require 'ecb)
;;(global-set-key "\C-c\C-w" 'ecb-activate)
;;(global-set-key "\C-c\C-q" 'ecb-deactivate)
;;(require 'ecb-autoloads)

;; key maps
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
(global-set-key "\C-c\C-v" 'browse-url)

(global-set-key "\C-l" 'goto-line)

;; these don't work with textmate.el?
;;(define-key osx-key-mode-map (kbd "A-[") 'previous-buffer)
;;(define-key osx-key-mode-map (kbd "A-]") 'next-buffer)

;; dynamic abbreviations
(global-set-key (kbd "C-<tab>") 'dabbrev-expand)
(define-key minibuffer-local-map (kbd "C-<tab>") 'dabbrev-expand)

  ;; Allow narrowing - restrict edits to page, region or defun
(put 'narrow-to-defun 'disabled nil)     
(put 'narrow-to-page 'disabled nil)     
(put 'narrow-to-region 'disabled nil)
  
(defalias 'qrr 'query-replace-regexp)

;; colors and fonts
(add-to-list 'load-path "~/.emacs.d/steve/color-theme")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-zenburn)))

(set-face-attribute 'default nil :family "Monaco" :height 140 :weight 'normal)
(set-face-attribute 'font-lock-string-face nil :family "Monaco" :height 140)

;; set tabs
(setq indent-tabs-mode nil)
(setq c-basic-offset 2)
(setq js-indent-level 2)
(setq tab-width 2)
(setq-default tab-width 2)
(setq indent-line-function 'insert-tab)

;; github
(setq gist-view-gist t)

;; rails setup
(add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-rails"))
(require 'rails)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/rinari"))
(require 'rinari)

(add-to-list 'auto-mode-alist '("\\.scss$" . sass-mode))
(global-set-key "\C-c\C-m" 'magit-status)

;; Install mode-compile to give friendlier compiling support!
;;(autoload 'mode-compile "mode-compile"
;;   "Command to compile current buffer file based on the major mode" t)
;;(global-set-key "\C-cc" 'mode-compile)
;;(autoload 'mode-compile-kill "mode-compile"
;; "Command to kill a compilation launched by `mode-compile'" t)
;;(global-set-key "\C-ck" 'mode-compile-kill)

(defun eshell-banner-message "")
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
(add-to-list 'load-path "~/.emacs.d/textmate")
(require 'textmate)
(textmate-mode) 

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
