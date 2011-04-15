
;; ecb setup
(add-to-list 'load-path "~/.emacs.d/ecb")
(load-file "~/.emacs.d/ecb/ecb.el")
(require 'ecb)
(global-set-key "\C-c\C-w" 'ecb-activate)
(global-set-key "\C-c\C-q" 'ecb-deactivate)
;;(require 'ecb-autoloads)

;; key maps
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
;; dynamic abbreviations
(global-set-key (kbd "C-<tab>") 'dabbrev-expand)
(define-key minibuffer-local-map (kbd "C-<tab>") 'dabbrev-expand)

;; Allow narrowing - restrict edits to page, region or defun
(put 'narrow-to-defun 'disabled nil)     
(put 'narrow-to-page 'disabled nil)     
(put 'narrow-to-region 'disabled nil)
  
(defalias 'qrr 'query-replace-regexp)

;; colors and fonts
(add-to-list 'load-path "~/.emacs.d/color-theme")
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
(setq github-user "stw")
(setq github-token "5e8fe6cfe63f0197c43745fd6fdd7e2a")

;; rails setup
(add-to-list 'load-path (expand-file-name "~/.emacs.d/rails-minor-mode"))
(require 'rails)
(add-to-list 'auto-mode-alist '("\\.scss$" . sass-mode))
(global-set-key "\C-c\C-m" 'magit-status)

; Install mode-compile to give friendlier compiling support!
(autoload 'mode-compile "mode-compile"
   "Command to compile current buffer file based on the major mode" t)
(global-set-key "\C-cc" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
 "Command to kill a compilation launched by `mode-compile'" t)
(global-set-key "\C-ck" 'mode-compile-kill)

;; customize org-mode
(setq org-startup-indented t)
(setq org-directory "~/org")
(setq org-mobile-inbox-for-pull "~/org/inbox.org")
(setq org-mobile-directory "~/.dropbox_files/Dropbox/MobileOrg")
(setq org-default-notes-file (concat org-directory "/inbox.org"))

(setq explicit-shell-file-name "/bin/bash")
(display-time)

;;(ecb-activate)
;;(split-window-vertically)
;;(slime)

