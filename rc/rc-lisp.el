;; -*- coding: utf-8 -*-
;;
;; Filename: rc-lisp.el
;; Created:  Thu May 1 16:30:43 2014 +0400
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package inf-lisp)
(use-package info-look)

(setq inferior-lisp-program "sbcl")
(setq common-lisp-hyperspec-root (file-truename custom/hyperspec-root))

(defun custom/lisp-mode-hook ()
  (auto-fill-mode 1)
  (paredit-mode 1)
  (paren-face-mode)
  (setq indent-tabs-mode t)
  (setq tab-width 2)
  (turn-on-eldoc-mode))

(defun custom/slime-hook ()
  (slime-mode t)
  (set (make-local-variable 'slime-lisp-implementations)
       (list (assoc 'sbcl slime-lisp-implementations))))

(use-package slime
  :defer t
  :init
  (progn
    (use-package slime-autoloads)
    (use-package ac-slime)
    (add-hook 'lisp-mode-hook 'custom/slime-hook)
    (add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
    (add-hook 'slime-mode-hook (lambda () (slime-autodoc-mode t)))
    (add-hook 'lisp-mode-hook 'custom/lisp-mode-hook)
    (add-hook 'lisp-mode-hook 'common-hooks/newline-hook)
    (add-hook 'lisp-mode-hook 'common-hooks/prog-helpers)
    (add-hook 'lisp-mode-hook 'set-up-slime-ac)
    (add-hook 'slime-mode-hook 'set-up-slime-ac)
    (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
    (eval-after-load "auto-complete"
      '(add-to-list 'ac-modes 'slime-repl-mode)))
  :config
  (progn
    (slime-setup
     '(slime-fancy-inspector slime-fancy-trace slime-fontifying-fu
                             slime-hyperdoc slime-package-fu slime-references
                             slime-snapshot slime-sprof slime-trace-dialog slime-xref-browser
                             slime-asdf slime-autodoc slime-banner slime-fancy slime-fuzzy
                             slime-repl slime-sbcl-exts))
    (defadvice slime-documentation-lookup
        (around change-browse-url-browser-function activate)
      "Use w3m for slime documentation lookup."
      (let ((browse-url-browser-function 'w3m-browse-url))
        ad-do-it))
    (setq slime-complete-symbol*-fancy t)
    (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
    (setq slime-net-coding-system 'utf-8-unix)
    (setq slime-lisp-implementations '((clojure ("clj-cmd") :init swank-clojure-init)))
    (setq slime-use-autodoc-mode nil)
    (setq slime-backend (concat (car (f-glob "slime-*" (at-config-basedir "elpa"))) "/swank-loader.lisp"))
    (add-to-list 'slime-lisp-implementations '(sbcl ("sbcl")  :coding-system utf-8-unix))
    ;;TODO: make more concrete use of helm-slime, see comments at https://github.com/emacs-helm/helm-slime/blob/master/helm-slime.el
    (defhydra hydra-slime ()
      "
Slime
-----------
_s_ run
_l_ selector
_;_ insert balanced comments
_M-;_ remove balanced comments
_h_ documentation lookup
"
      ("s" slime "run slime" :color blue)
      ("l" slime-selector "slime selector" :color blue)
      (";" slime-insert-balanced-comments)
      ("M-;" slime-remove-balanced-comments)
      ("h" slime-documentation-lookup)
      ("q" nil "cancel"))
    (global-set-key (kbd "M-p") 'hydra-slime/body)
    ))

;; lookup information in hyperspec
(info-lookup-add-help
 :mode 'lisp-mode
 :regexp "[^][()'\" \t\n]+"
 :ignore-case t
 :doc-spec '(("(ansicl)Symbol Index" nil nil nil)))

(provide 'rc-lisp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; rc-lisp.el ends here
