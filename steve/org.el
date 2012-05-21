
(add-to-list 'load-path (expand-file-name "~/.emacs.d/org-mode/lisp"))
(require 'org-install)

;; key bindings
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key (kbd "<f12>") 'org-agenda)
(global-set-key (kbd "S-<f11>") 'org-clock-in)
(global-set-key (kbd "C-<f11>") 'org-clock-out)

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
;; (setq org-todo-keywords (quote (( sequence "TODO(t)" "Done(d!/!)")))) 
(setq org-todo-keywords (quote ((sequence "TODO(t)" "NEXT(n)" "STARTED(s)" "WAITING(w@/!)" "SOMEDAY(S!)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
                                 (sequence "QUOTE(Q!)" "QUOTED(D!)" "|" "APPROVED(A@)" "EXPIRED(E@)" "REJECTED(R@)")
                                 (sequence "OPEN(O!)" "|" "CLOSED(C!)"))))
(setq org-use-fast-todo-selection t)
(setq org-treat-S-cursor-todo-selection-as-state-change nil)

(setq org-todo-state-tags-triggers
      (quote (("CANCELLED"
               ("CANCELLED" . t))
              ("WAITING"
               ("WAITING" . t))
              ("SOMEDAY"
               ("WAITING" . t))
              (done
               ("WAITING"))
              ("TODO"
               ("WAITING")
               ("CANCELLED"))
              ("NEXT"
               ("WAITING"))
              ("STARTED"
               ("WAITING"))
              ("DONE"
               ("WAITING")
               ("CANCELLED")))))

(defun bh/clock-in-to-started (kw)
  "Switch task from TODO or NEXT to STARTED when clocking in.
Skips capture tasks and tasks with subtasks"
  (if (and (member (org-get-todo-state) (list "TODO" "NEXT"))
           (not (and (boundp 'org-capture-mode) org-capture-mode))
           (not (bh/is-project-p)))
      "STARTED"))

;; Remove empty LOGBOOK drawers on clock out
(defun bh/remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "LOGBOOK" (point))))

(add-hook 'org-clock-out-hook 'bh/remove-empty-drawer-on-clock-out 'append)

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
(global-set-key (kbd "C-M-r") 'org-capture)

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, and org-protocol
(setq org-capture-templates (quote (
                                    ("t" "todo" entry (file "~/org/inbox.org") "* TODO %?
%U
%a" :clock-in t :clock-resume t)
                                    ("n" "note" entry (file "~/org/inbox.org") "* %?                                                                            :NOTE:
%U
%a
:LOGBOOK:
:END:" :clock-in t :clock-resume t)
                                    ("j" "Journal" entry (file+datetree "~/org/journal.org") "* %?
%U" :clock-in t :clock-resume t)
                                    ("w" "org-protocol" entry (file "~/org/inbox.org") "* TODO Review %c
%U" :immediate-finish t)
                                    ("p" "Phone call" entry (file "~/org/inbox.org") "* PHONE %(bh/phone-call) - %(gjg/bbdb-company) :PHONE:
%U

%?" :clock-in t :clock-resume t)
                                    ("h" "Habit" entry (file "~/org/inbox.org") "* TODO %?
SCHEDULED: %t
:PROPERTIES:
:STYLE: habit
:END:"))))

;; (find-file "~/org/business.org")
