
;; Mail setup
(require 'nnimap)
(require 'smtpmail)

(setq gnus-verbose 10)
(setq starttls-use-gnutls t)
(setq mail-host-address "mbp.walkertek.com")

(setq gnus-secondary-select-methods
      '((nnimap "imap.everyone.net"
                (nnimap-address "imap.everyone.net")
                (nnimap-stream tls))))

(setq send-mail-function 'smtpmail-send-it
      message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.everyone.net" 587 nil nil))
      smtpmail-auth-credentials (expand-file-name "~/.authsmtp")
      smtpmail-default-smtp-server "smtp.everyone.net"
      smtpmail-smtp-server "smtp.everyone.net"
      smtpmail-smtp-service 587
      smtpmail-debug-info t)

