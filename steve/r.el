(setq ess-directory "~/src/r/ess")
(setq ess-ask-for-ess-directory nil)
(setq ess-local-process-name "R")
(setq ansi-color-for-comint-mode 'filter)
(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-to-bottom-on-output t)
(setq comint-move-point-for-output t)

;;(ansi-color-process-output comint-postoutput-scroll-to-bottom comint-watch-for-password-prompt)

(require 'ess-site)
