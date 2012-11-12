
(add-to-list 'load-path (expand-file-name "~/.emacs.d/org-mode/lisp"))
(require 'org-install)

(setq org-use-fast-todo-selection 'expert)
(setq org-agenda-skip-if-done t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-scheduled-if-done t)
(setq org-treat-S-cursor-todo-selection-as-state-change nil)
(setq org-log-done t)
(setq org-icalendar-include-todo t)
(setq org-combined-agenda-icalendar-file "~/org/org.ics")
(setq org-agenda-time-grid '((daily require-timed)
                             "--------------------"
                             (800 1000 1200 1400 1600 1800 2000 2200)))

;; key bindings
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key (kbd "<f12>") 'org-agenda)
(global-set-key (kbd "S-<f11>") 'org-clock-in)
(global-set-key (kbd "C-<f11>") 'org-clock-out)
(global-set-key (kbd "C-c r") 'org-remember)

;; org mode in gnus
(setq message-mode-hook
      (quote (orgstruct++-mode
              (lambda nil (setq fill-column 72) (flyspell-mode 1))
              turn-on-auto-fill
              bbdb-define-all-aliases)))

;; Make TAB the yas trigger key in the org-mode-hook and enable flyspell mode and autofill
(add-hook 'org-mode-hook
          (lambda ()
            ;; turn of mate mode
            (textmate-mode 0)
            ;; yasnippet
            (make-variable-buffer-local 'yas/trigger-key)
            (org-set-local 'yas/trigger-key [tab])
            (define-key yas/keymap [tab] 'yas/next-field-group)
            ;; flyspell mode for spell checking everywhere
            (flyspell-mode 1)
            ;; rebind control enter
            (define-key cua-global-keymap cua-rectangle-mark-key 'org-insert-heading-respect-content)
            ;; Undefine C-c [ and C-c ] since this breaks my org-agenda files when directories are include
            ;; It expands the files in the directories individually
            (org-defkey org-mode-map "\C-c["    'undefined)
            (org-defkey org-mode-map "\C-c]"    'undefined)
            (local-set-key (kbd "C-c M-o") 'bh/mail-subtree)))

;; todo state keywords C-c C-t KEY
(setq org-todo-keywords (quote (( sequence "TODO(t)" "DONE(d!/!)")))) 
;; (setq org-todo-keywords (quote ((sequence "TODO(t)" "NEXT(n)" "STARTED(s)" "WAITING(w@/!)" "SOMEDAY(S!)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
;;                                 (sequence "QUOTE(Q!)" "QUOTED(D!)" "|" "APPROVED(A@)" "EXPIRED(E@)" "REJECTED(R@)")
;;                                 (sequence "OPEN(O!)" "|" "CLOSED(C!)"))))

;; (setq org-todo-state-tags-triggers
;;       (quote (("CANCELLED"
;;                ("CANCELLED" . t))
;;               ("WAITING"
;;                ("WAITING" . t))
;;               ("SOMEDAY"
;;                ("WAITING" . t))
;;               (done
;;                ("WAITING"))
;;               ("TODO"
;;                ("WAITING")
;;                ("CANCELLED"))
;;               ("NEXT"
;;                ("WAITING"))
;;               ("STARTED"
;;                ("WAITING"))
;;               ("DONE"
;;                ("WAITING")
;;                ("CANCELLED")))))

;; (defun bh/clock-in-to-started (kw)
;;   "Switch task from TODO or NEXT to STARTED when clocking in.
;; Skips capture tasks and tasks with subtasks"
;;   (if (and (member (org-get-todo-state) (list "TODO" "NEXT"))
;;            (not (and (boundp 'org-capture-mode) org-capture-mode))
;;            (not (bh/is-project-p)))
;;       "STARTED"))

;; ;; Remove empty LOGBOOK drawers on clock out
;; (defun bh/remove-empty-drawer-on-clock-out ()
;;   (interactive)
;;   (save-excursion
;;     (beginning-of-line 0)
;;     (org-remove-empty-drawer-at "LOGBOOK" (point))))

;; (add-hook 'org-clock-out-hook 'bh/remove-empty-drawer-on-clock-out 'append)

;; refiling
; Use IDO for target completion
(setq org-completion-use-ido t)

; Targets include this file and any file contributing to the agenda - up to 5 levels deep
(setq org-refile-targets (quote ((org-agenda-files :maxlevel . 5) (nil :maxlevel . 5))))

; Targets start with the file name - allows creating level 1 tasks
(setq org-refile-use-outline-path (quote file))

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use IDO for both buffer and file completion and ido-everywhere to t
; These are set via the customize interface since setq's do not
; work according to the docstring
;
; '(ido-mode (quote both) nil (ido))
; '(ido-everywhere t)

;; customize org-mode
(setq org-startup-indented t)
(setq org-directory "~/org")

;; mobile setup
(setq org-mobile-inbox-for-pull "~/org/inbox.org")
(setq org-mobile-directory "~/.dropbox_files/Dropbox/MobileOrg")
(setq org-mobile-force-id-on-agenda-items nil)

(setq org-default-notes-file (concat org-directory "/inbox.org"))
(setq org-agenda-files (list "~/org/business.org" "~/org/personal.org" "~/org/inbox.org"))
(setq org-return-follows-link t)
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
(add-to-list 'auto-mode-alist '("README" . org-mode))
;;(setq org-tab-follows-link nil)
(setq org-confirm-elisp-link-function nil)
;;(setq org-file-apps "*")
;; (setq org-agenda-repeating-timestamp-show-all nil)

;; C-M-r to start capture mode
(global-set-key (kbd "C-c c") 'org-capture)

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, and org-protocol
(setq org-capture-templates '(
                              ("t" "Create Todo" entry (file+headline "~/org/business.org" "Office") "* TODO %? :Office:" :clock-in t :clock-resume t)
                              ("p" "New Phone Call" entry (file+headline "~/org/business.org" "Calls") "* PHONE %? :PHONE:" :clock-in t :clock-resume t)
                              ("j" "Create Journal Entry" entry (file+datetree "~/org/journal.org") "* %? %U" :clock-in t :clock-resume t)
                              ("n" "Create Note" entry (file+headline "~/org/inbox.org" "Notes") (file "~/org/note.tpl") :clock-in t :clock-resume t)
                              ))

;; remember functionality
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)

;; (org-remember-insinuate)

;; (setq org-remember-templates
;;      '(("Todo" ?t "* TODO %? %^g\n %i\n " "~/org/business.org" "Office")
;;       ("Calls" ?c "\n* %^{Name} %T :CONTACT:\n\t%?" 
;;        "~/org/calls.org")
;;       ("Journal" ?j "\n* %^{topic} %T \n%i%?\n" "~/org/journal.org")
;;       ("Book" ?b "\n* %^{Book Title} %t :READING: \n%[~/org/booktemp.txt]\n" 
;;        "~/org/journal.org")
;;      ))

(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
(setq org-clock-idle-time 15)

(find-file "~/org/index.org")

;; (add-hook 'org-mode-hook '(lambda ()
;;                             (add-hook 'after-save-hook 'org-mobile-push t t))))

(setq org-link-abbrev-alist
      '(("dev"    . "http://%s.dev.walkertek.com")
        ("google" . "http://www.google.com/search?q=")
        ("gmap"   . "http://maps.google.com/maps?q=%s")
        ("yf"     . "http://finance.yahoo.com/q/ks?s=%s+Key+Statistics")
        ("gf"     . "http://www.google.com/finance?q=%s")
        ("sc"     . "http://stockcharts.com/h-sc/ui?s=%s")
        ))

