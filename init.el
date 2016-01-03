(setq config-basedir (file-name-directory
                      (or (buffer-file-name) load-file-name)))

(defun at-config-basedir (&optional suffix)
  (concat config-basedir suffix))

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/"))
(setf (cdr (assoc "gnu" package-archives))
      "https://elpa.gnu.org/packages/")
(package-initialize)

(mapcar
 (lambda (package)
   (unless (package-installed-p package)
     (package-install package)))
 ;;base system packages for bootstrapping
 '(bind-key use-package))

(require 'use-package)
(setq use-package-verbose t)
(setq load-prefer-newer t)

(use-package auto-compile
  :ensure t
  :config
  (auto-compile-on-load-mode 1)
  (auto-compile-on-save-mode 1)
  (setq auto-compile-display-buffer nil)
  (setq auto-compile-mode-line-counter t))

(use-package f :ensure t)
(use-package diminish :ensure t)
(use-package names :ensure t)
(use-package org-plus-contrib :ensure t)
(setq org-modules
      '(org-agenda org-archive org-attach org-bbdb org-bibtex org-bookmark
        org-checklist org-clock org-collector org-docview org-drill org-expiry
        org-habit org-id org-info org-inlinetask org-interactive-query org-irc
        org-man org-mouse org-protocol org-timer org-w3m))
(use-package anaphora :ensure t)

(org-babel-load-file (at-config-basedir "config.org"))
