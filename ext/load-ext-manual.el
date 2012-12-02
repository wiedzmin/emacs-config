(add-to-list 'load-path (concat config-basedir "/ext/ecb"))
(add-to-list 'load-path (concat config-basedir "/ext/crosshairs"))
(add-to-list 'load-path (concat config-basedir "/ext/bookmark+"))
(add-to-list 'load-path (concat config-basedir "/ext/emacs-jabber"))
(add-to-list 'load-path (concat config-basedir "/ext/emacs-nav"))
(add-to-list 'load-path (concat config-basedir "/ext/git-contrib/emacs"))
(add-to-list 'load-path (concat config-basedir "/ext/php"))
(add-to-list 'load-path (concat config-basedir "/ext/projectile"))
(add-to-list 'load-path (concat config-basedir "/ext/slime"))
(add-to-list 'load-path (concat config-basedir "/ext/slime/contrib"))
(add-to-list 'load-path (concat config-basedir "/ext/twittering-mode"))
;; (add-to-list 'load-path (concat config-basedir "/ext/ghc-mod"))

(load (concat config-basedir "/ext/rainbow-mode.el"))
(load (concat config-basedir "/ext/php/php-mode/php-mode.el"))
(load (concat config-basedir "/ext/php/php-electric.el")) ;; AFTER php-mode !!!
(load (concat config-basedir "/ext/python/python-pep8.el"))
(load (concat config-basedir "/ext/python/python-pylint.el"))
;; (load (concat config-basedir "/ext/quick-jump.el"))
(load (concat config-basedir "/ext/rst.el")) ; nonwiki
(load (concat config-basedir "/ext/smerge-mode.el"))

;; (add-to-list 'load-path (concat config-basedir "/ext/frame-tag.el"))
;; (add-to-list 'load-path (concat config-basedir "/ext/python/pymacs"))
;; (load (concat config-basedir "/ext/dired+.el"))
;; (load (concat config-basedir "/ext/joseph-go-to-char.el"))
;; (load (concat config-basedir "/ext/multi-term.el"))
;; (load (concat config-basedir "/ext/naquadah-theme/naquadah-theme.el"))
;; (load (concat config-basedir "/ext/nxhtml/autostart.el"))
;; (load (concat config-basedir "/ext/pretty-mode.el"))
