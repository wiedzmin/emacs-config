;;; init-search.el --- 

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet

(require 'highlight-symbol)
(require 're-builder)
(require 'full-ack)
(require 'ioccur)


;#############################################################################
;#   full-ack setup
;############################################################################
(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)
(autoload 'kill-ring-search "kill-ring-search" "Search the kill ring in the minibuffer." (interactive))


;#############################################################################
;#   Keybindings
;############################################################################
(global-set-key [C-f3] 'highlight-symbol-at-point)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [S-f3] 'highlight-symbol-prev)
(global-set-key "\M-\C-y" 'kill-ring-search)
(global-set-key "\C-cs" 'multi-occur-in-matching-buffers)
(global-set-key "\C-cug" 'rgrep)
(global-set-key "\C-cua" 'ack)
(global-set-key "\C-coo" 'occur)
(global-set-key "\C-cur" 're-builder)
(global-set-key "\C-coi" 'ioccur)
(global-set-key "\C-cob" 'ioccur-find-buffer-matching)

;;; init-search.el ends here
