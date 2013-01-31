;; emacs for python
;; had to edit emacs-for-python/extensions/python.el 1530, remove 23.3

(setq ropemacs-global-prefix (kbd "C-c m"))

(add-to-list 'load-path "~/.emacs.d/plugins/emacs-for-python")
(load-file "~/.emacs.d/plugins/emacs-for-python/epy-init.el")

(epy-setup-checker "pyflakes %f")

(epy-django-snippets)

(epy-setup-ipython)
