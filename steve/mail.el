;; Mail setup
(require 'nnimap)
(require 'smtpmail)

(add-to-list 'load-path "~/src/emacs/BBDB/lisp")
(require 'bbdb)
(bbdb-initialize) 


(setq mail-host-address "walkertek.com")
(setq gnus-verbose 10)
(setq starttls-use-gnutls t)
(setq gnus-agent nil)

(setq gnus-select-method '(nnimap "gmail"
				  (nnimap-address "imap.gmail.com")
				  (nnimap-server-port 993)
				  (nnimap-stream ssl)))

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 587 "swalker@walkertek.com" nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      smtpmail-local-domain "walkertek.com")

;; Make Gnus NOT ignore [Gmail] mailboxes
;; (setq gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")
