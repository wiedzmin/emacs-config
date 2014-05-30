;; -*- coding: utf-8 -*-
;;
;; Filename: rc-clients.el
;; Created: Пт май 30 18:58:37 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'twit "twittering-mode" nil t)
(autoload 'mingus "mingus" nil t)

(eval-after-load "erc"
  '(progn
     (require 'erc-join)
     (require 'erc-lang)
     (require 'erc-fill)
     (require 'erc-log)
     (require 'erc-autoaway)
     (require 'erc-services)
     (require 'erc-menu)
     (require 'erc-ring)
     (require 'erc-match)

     (add-to-list 'erc-modules 'match)
     (erc-update-modules)
     (erc-autojoin-mode t)
     (erc-fill-mode t)
     (erc-nickserv-mode 1)
     (erc-ring-mode t)
     (erc-match-enable)
     (erc-match-mode 1)
     (erc-timestamp-mode t)

     (setq erc-user-full-name custom/erc-full-name)
     (setq erc-email-userid custom/gmail-address)
     (setq erc-log-insert-log-on-open nil)
     (setq erc-log-channels t)
     (setq erc-log-channels-directory custom/erc-logs-directory)
     (setq erc-save-buffer-on-part t)
     (setq erc-hide-timestamps nil)
     (setq erc-max-buffer-size 20000)
     (setq erc-autoaway-idle-seconds 1200)
     (setq erc-autoaway-message custom/erc-autoaway-message)
     (setq erc-auto-discard-away t)
     (setq erc-auto-query 'buffer)
     (setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT"))
     (setq erc-prompt-for-nickserv-password nil)
     (setq erc-nickserv-passwords
           '((freenode     ((custom/erc-nick . custom/erc-nickserv-password)
                            (custom/erc-nick . custom/erc-nickserv-password)))))
     (setq erc-encoding-coding-alist
           '(("#debian-russian" . cyrillic-koi8)
             ("#altlinux" . cyrillic-koi8)
             ("#unix.ru" . cyrillic-koi8)
             ("#fidorus" . cyrillic-koi8)))
     (setq erc-nick custom/erc-main-nick)
     (setq erc-nick-uniquifier "_")
     (setq erc-prompt-for-password nil)
     (setq erc-kill-queries-on-quit t)
     (setq erc-server-coding-system '(cp1251 . cp1251))

     (defvar bitlbee-password "geheim")

     (defun bitlbee-identify ()
       "If we're on the bitlbee server, send the identify command to the &bitlbee channel."
       (when (and (string= "localhost" erc-session-server)
                  (string= "&bitlbee" (buffer-name)))
         (erc-message "PRIVMSG" (format "%s identify %s"
                                        (erc-default-target)
                                        bitlbee-password))))
     (add-hook 'erc-join-hook 'bitlbee-identify)

     (defun erc-cmd-ICQWHOIS (uin)
       "Queries icq-user with UIN `uin', and returns the result."
       (let* ((result (myerc-query-icq-user uin))
              (fname (cdr (assoc 'fname result)))
              (lname (cdr (assoc 'lname result)))
              (nick (cdr (assoc 'nick result))))
         (erc-display-message nil 'notice (current-buffer) (format "%s (%s %s)" nick fname lname))))
     ))

(eval-after-load "twittering-mode"
  '(progn
     (setq twittering-use-master-password t)
     ))

(eval-after-load "mingus"
  '(progn
     (global-set-key (kbd "C-c <right>") 'mingus-seek)
     (global-set-key (kbd "C-c <left>") 'mingus-seek-backward)
     (global-set-key (kbd "C-c s") 'mingus)
     (define-key mingus-playlist-map (kbd "<Backspace>") 'mingus-del)
     ))

(provide 'rc-clients)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-clients.el ends here
