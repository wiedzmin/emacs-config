;; -*- coding: utf-8 -*-
;;
;; Filename: custom-publishing.el
;; Created: Сб май 31 23:29:10 2014 (+0400)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun unicode-cyrillic-to-8859-5 ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let ((re (format "[%c-%c]+"
          (decode-char 'ucs #x0400) (decode-char 'ucs #x04ff)))
    (case-fold-search nil)
    pos)
      (while (re-search-forward re nil 'move)
  (setq pos (match-beginning 0))
  (encode-coding-region pos (point) 'iso-8859-5)
  (decode-coding-region pos (point) 'iso-8859-5)))))

(defun custom/ps-print-buffer-with-faces ()
  (interactive)
  (ps-print-buffer-with-faces (concat
             ps-print-path "/"
             (buffer-name) "-"
             (format-time-string "%Y-%m-%dT%H-%M-%S") ".ps")))

(defun custom/ps-print-region-with-faces ()
  (interactive)
  (ps-print-region-with-faces (region-beginning) (region-end) (concat
                     ps-print-path "/"
                     (buffer-name) "-"
                     (format-time-string "%Y-%m-%dT%H-%M-%S") "-region.ps")))

(provide 'custom-publishing)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; custom-publishing.el ends here
