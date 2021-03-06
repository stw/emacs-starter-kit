;; set up the default font
;; note: to turn off antialiasing for all fonts less than or equal to
;; 10 point, run the following command
;;    defaults write org.gnu.AquamacsEmacs AppleAntiAliasingThreshold 10
;;    defaults write org.gnu.Emacs AppleAntiAliasingThreshold 10
;;(set-default-font "-apple-monaco-medium-r-normal-*-9-*-*-*-*-*-*-*")
;;(set-default-font "-apple-profont-medium-r-*-*-10-*-*-*-*-*-*-*")
(set-default-font "-apple-profont-medium-r-*-12-*-*-*-*-*-*-*-*")
(global-font-lock-mode 1)

(fringe-mode -1)
(global-hl-line-mode t)

;; Turn off mouse interface early in startup to avoid momentary display
;; You really don't need these; trust me.
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(add-to-list 'load-path dotfiles-dir)
(add-to-list 'load-path (concat dotfiles-dir "/elpa-to-submit"))

(setq autoload-file (concat dotfiles-dir "loaddefs.el"))
(setq package-user-dir (concat dotfiles-dir "elpa"))
(setq custom-file (concat dotfiles-dir "custom.el"))
(load custom-file 'noerror)

(require 'package)
(dolist (source '(
;;                  ("technomancy" . "http://repo.technomancy.us/emacs/")
;;                  ("elpa" . "http://tromey.com/elpa/")
                  ("marmalade" . "http://marmalade-repo.org/packages/")))
  (add-to-list 'package-archives source t))
(package-initialize)

(add-to-list 'load-path (concat dotfiles-dir "/plugins/starter-kit"))
(require 'starter-kit-elpa)

;; These should be loaded on startup rather than autoloaded on demand
;; since they are likely to be used in every session

(require 'cl)
(require 'saveplace)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)

;; Load up starter kit customizations

(require 'starter-kit-defuns)
(require 'starter-kit-bindings)
(require 'starter-kit-misc)
(require 'starter-kit-registers)
(require 'starter-kit-eshell)

(add-to-list 'load-path (concat dotfiles-dir "/plugins/slime"))
(require 'starter-kit-lisp)

(require 'starter-kit-perl)
(require 'starter-kit-ruby)
(require 'starter-kit-js)

(add-to-list 'load-path (concat dotfiles-dir "/plugins/org-mode/lisp"))
(require 'org)
(setq org-src-fontify-natively t)

(add-to-list 'load-path (concat dotfiles-dir "/plugins/mmm-mode"))
(add-to-list 'load-path (concat dotfiles-dir "/plugins/psgml"))

(add-to-list 'load-path (concat dotfiles-dir "/plugins/yasnippet"))
(require 'yasnippet)
(yas/minor-mode 1)
;;(yas/global-mode 1)

(add-to-list 'load-path (concat dotfiles-dir "/plugins/auto-complete"))
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/auto-complete/dict")
(require 'auto-complete-config)
(ac-config-default)

(add-to-list 'load-path (concat dotfiles-dir "/plugins/js2-mode"))
(require 'js2-mode)

(regen-autoloads)
(load custom-file 'noerror)

;; You can keep system- or user-specific customizations here
(setq system-specific-config (concat dotfiles-dir system-name ".el")
      user-specific-config (concat dotfiles-dir user-login-name ".el")
      user-specific-dir (concat dotfiles-dir user-login-name))
(add-to-list 'load-path user-specific-dir)

;;(if (file-exists-p system-specific-config) (load system-specific-config))
(if (file-exists-p user-specific-config) (load user-specific-config))
(if (file-exists-p user-specific-dir)
  (mapc #'load (directory-files user-specific-dir nil ".*el$")))

(setq aquamacs-scratch-file "~/src/emacs/scratch.org")

(modify-frame-parameters (selected-frame) '((alpha . 90)))

;;(smart-frame-positioning-mode nil)

;; resize the initial emacs window
;; (setq initial-frame-alist '((width . 120)
;;                             (height . 65)
;;                             (left . 50)
;;                             (top . 50)))
;; (setq default-frame-alist '((width . 120)
;;                             (height . 65)
;;                             (left . 50)
;;                             (top . 50)))
