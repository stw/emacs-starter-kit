;; command logging
;; (add-hook 'rinari-mode-hook (function mwe:log-keyboard-commands))

;; coffee-mode
(add-to-list 'load-path "~/.emacs.d/coffee-mode")
(require 'coffee-mode)

(add-to-list 'load-path "~/.emacs.d/js2-mode")
(require 'js2-mode)
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; bookmark+
(add-to-list 'load-path "~/.emacs.d/bookmark+") 
(require 'bookmark+)

;; textmate 
(add-to-list 'load-path "/Users/steve/.emacs.d/textmate")
(require 'textmate)
(textmate-mode)

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

(require 'slime)
(add-to-list 'slime-lisp-implementations
             '(sbcl ("sbcl")))

;;(add-to-list 'load-path "~/.emacs.d/steve/gist.el")
;;(require 'gist)

;;(ecb-activate)
;;(split-window-vertically)
;;(slime)

