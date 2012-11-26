;;; rc-flymake.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

(require 'flymake-cursor)

(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "pyflakes" (list local-file))))

(defun flymake-php-init ()
  "Use php and phpcs to check the syntax and code compliance of the current file."
  (let* ((temp (flymake-init-create-temp-buffer-copy
                'flymake-create-temp-inplace))
         (local (file-relative-name temp (file-name-directory
                                          buffer-file-name))))
    (list "php_lint" (list local))))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.php\\'" flymake-php-init))
  )

;;This is the error format for : php -f somefile.php -l
(add-to-list
 'flymake-err-line-patterns
 '("\(Parse\|Fatal\) error: +\(.?\) in \(.?\) on line \([0-9]+\)$" 3 4 nil 2))

(add-hook 'python-mode-hook 'flymake-find-file-hook)
(add-hook 'php-mode-hook 'flymake-find-file-hook)

(global-set-key (kbd "C-x <up>") 'flymake-goto-prev-error)
(global-set-key (kbd "C-x <down>") 'flymake-goto-next-error)

(provide 'rc-tools-flymake)

;;; rc-flymake.el ends here
