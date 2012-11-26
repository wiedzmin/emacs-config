;;; emacs-rc-python.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(autoload 'python-pylint "python-pylint")
(autoload 'pylint "python-pylint")

;#############################################################################
;#   Custom definitions
;############################################################################
(defun electric-pair ()
  "Insert character pair without surrounding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))


;#############################################################################
;#   Hooks
;############################################################################
(defun custom/python-mode-hook ()
  (auto-fill-mode 1)
  (eldoc-mode 1)
  (setq indent-tabs-mode nil)
  (setq tab-width 4)
  (turn-on-eldoc-mode)
  (define-key python-mode-map (kbd "\"") 'electric-pair)
  (define-key python-mode-map (kbd "\'") 'electric-pair)
  (define-key python-mode-map (kbd "(") 'electric-pair)
  (define-key python-mode-map (kbd "[") 'electric-pair)
  (define-key python-mode-map (kbd "{") 'electric-pair)
  (define-key python-mode-map (kbd "C-c l") 'pylint)
  (define-key python-mode-map (kbd "C-c p e") 'pep8)
  (define-key python-mode-map (kbd "C-c C-e") 'python-end-of-block)
  )

(add-hook 'python-mode-hook 'custom/python-mode-hook)
(add-hook 'python-mode-hook 'common-hooks/comment-hook)
(add-hook 'python-mode-hook 'common-hooks/show-prog-keywords)
;; (add-hook 'python-mode-hook 'flyspell-prog-mode)
(add-hook 'python-mode-hook 'common-hooks/newline-hook)

(setenv "PYTHONPATH"
        (concat
         "/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7:"
         "/Users/octocat/workspace/opossum/src:"
         "/Users/octocat/workspace/webdrive/python:"
         (getenv "PYTHONPATH")))

(setenv "PYLINTRC"
        (concat
         config-basedir
         "contrib/.pylintrc"))

(provide 'rc-lang-python)

;;; emacs-rc-python.el ends here
