;;; emacs-rc-org-mode.el ---

;; Copyright (C) 2011 Alex Ermolov
;;
;; Author: aaermolov@gmail.com
;; Keywords:
;; Requirements:
;; Status: not intended to be distributed yet

;#############################################################################
;#   Load extensions
;############################################################################
(autoload 'icalendar-import-buffer "icalendar" "Import iCalendar data from current buffer" t)

(require 'org-install)
(require 'org)
(require 'org-agenda)
(require 'org-pomodoro)
(require 'org-protocol)
(require 'ox-html)

;#############################################################################
;#   Customizations
;############################################################################
(add-to-list 'file-coding-system-alist (cons "\\.\\(org\\|org_archive\\|/TODO\\)$"  'utf-8))

(setq org-agenda-files (all-files-under-dir-recursively (concat org-dir "/main") "org"))
;TODO: maybe do it less straightforward
(add-to-list 'org-agenda-files (concat config-basedir "/todo.org"))
(add-to-list 'org-agenda-files (concat config-basedir "/totry.org"))

; Targets include this file and any file contributing to the agenda - up to 5 levels deep
(setq org-refile-targets (quote ((org-agenda-files :maxlevel . 5) (nil :maxlevel . 5))))
(setq org-refile-use-outline-path (quote file))
(setq org-refile-allow-creating-parent-nodes (quote confirm))
(setq org-agenda-span 'month)
(setq org-deadline-warning-days 14)
(setq org-agenda-show-all-dates t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-todo-list-sublevels nil)
(setq org-agenda-start-on-weekday nil)
(setq org-agenda-include-diary t)
(setq org-agenda-include-all-todo t)
(setq org-reverse-note-order t)
(setq org-fast-tag-selection-single-key (quote expert))
(setq org-startup-folded nil)
(setq org-log-done t)
(setq org-hide-leading-stars t)
(setq org-use-property-inheritance t)
(setq org-special-ctrl-a/e t)
(setq org-special-ctrl-k t)
(setq org-blank-before-new-entry (quote ((heading . auto) (plain-list-item))))
(setq org-agenda-dim-blocked-tasks 'invisible)
(setq org-enforce-todo-checkbox-dependencies t)
(setq org-enforce-todo-dependencies t)
(setq org-default-notes-file custom/org-capture-file)
(setq org-insert-mode-line-in-empty-file t)
(setq org-log-done t) ;; read documentation
(setq org-ditaa-jar-path (concat config-basedir "resources/ditaa0_9.jar"))

(setq org-todo-keywords
      '((sequence "TODO(t)" "GOING(g!)" "WAITING(w@/!)" "LATER(l@)"
                  "|" "DONE(d!/@)" "SOMEDAY(s@)" "CANCELLED(c@/!)")
        (sequence "NEW(n)" "INPROGRESS(p!)" "CHECKING(r!)" "REWORK(f!@)" "|" "CLOSED(k!)")))
(setq org-todo-keywords-for-agenda '((sequence "TODO(t)" "WAITING(w)" "GOING(g)"
                                               "NEW(n)" "INPROGRESS(p)" "REWORK(f)")))
(setq org-done-keywords-for-agenda '((sequence "DONE(d)" "CANCELLED(c)")))
(setq org-agenda-time-grid
      '((daily today require-timed remove-match)
        "----------------"
        (930 1000 1200 1400 1600 1800 2000 2200 2400 2500)))
(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "red" :weight bold))
        ("NEW" . (:foreground "red" :weight bold))
        ("REWORK" . (:foreground "red" :weight bold))
        ("INPROGRESS" . (:foreground "yellow" :weight bold))
        ("WAITING" . (:foreground "orange" :weight bold))
        ("CANCELLED" . (:foreground "cyan" :weight bold))
        ("CHECKING" . (:foreground "orange" :weight bold))
        ("DONE" . (:foreground "green" :weight bold))
        ("CLOSED" . (:foreground "green" :weight bold))))
(setq org-priority-faces
      '((?A :foreground "red" :weight bold)
        (?B :foreground "#94bff3" :weight bold)
        (?C :foreground "#6f6f6f")))
(setq org-agenda-custom-commands
      '(("c" todo "DONE|SOMEDAY|CANCELLED|CLOSED" nil)
        ("w" todo "WAITING|LATER" nil)
        ("W" agenda "" ((org-agenda-ndays 21)))
        ("A" agenda ""
         ((org-agenda-skip-function
           (lambda nil
             (org-agenda-skip-entry-if 'notregexp)))
          (org-agenda-ndays 1)
          (org-agenda-overriding-header "Today's Priority #A tasks: ")))
        ("u" alltodo ""
         ((org-agenda-skip-function
           (lambda nil
             (org-agenda-skip-entry-if 'scheduled 'deadline 'regexp "<[^>\n]+>")))
          (org-agenda-overriding-header "Unscheduled TODO entries: ")))
        ("U" "Prioritized tasks"
         ((tags-todo "+PRIORITY=\"A\"")
          (tags-todo "+PRIORITY=\"B\"")
          (tags-todo "+PRIORITY=\"C\"")))
        ("jp" tags "+work+planning")
        ("te" tags "+ticket+emacs")
        ("tx" tags "+ticket+xmonad")
        ))
(setq org-capture-templates
      (quote
       (("d" "todo")
        ("dc" "chaos" entry (file (concat org-dir "/todo.org")) "* SOMEDAY %? %U :todo:chaos:")
        ("dt" "today" entry (file (concat org-dir "/todo.org")) "* TODO %? %U :todo:today:")
        ("dn" "tomorrow" entry (file (concat org-dir "/todo.org")) "* TODO %? %U :todo:tomorrow")
        ("do" "ordering" entry (file (concat org-dir "/ordering.org")) "* TODO %? %U :todo:ordering")
        ("de" "emacs")
        ("det" "emacs todo" entry (file (concat config-basedir "/todo.org")) "* TODO %? %U :emacs:ticket:")
        ("dey" "emacs try" entry (file+headline (concat config-basedir "/totry.org") "try") "* %? %U :emacs:try:")
        ("dp" "project ideas" entry (file (concat org-dir "/projects/ideas/projectideas.org")) "* %? %U :project:idea:")
        ("dx" "xmonad tickets" entry (file+headline (concat org-dir "/projects/config/xmonad.org") "tickets") "* %? %U :xmonad:ticket:")
        ("ds" "stumpwm tickets" entry (file+headline (concat org-dir "/projects/config/stumpwm.org") "tickets") "* %? %U :stumpwm:ticket:")
        ("dw" "workplace tasks" entry (file (concat org-dir "/workplace-tasks.org")) "* TODO %? %U :workplace:")
        ("j" "job")
        ("ji" "issues" entry (file+headline (concat org-dir "/job/issues.org") "list") "* %? %U :work:tasks:")
        ("jp" "plan" entry (file (concat org-dir "/job/plan.org")) "* TODO %? %U :work:planning:%(custom/scrum-timestamp-as-tag):")
        ("b" "browser tabs")
        ("bc" "clojure" entry (file+olp (concat org-inventory-dir "/review/browser-tabs.org") "firefox tabs" "clojure (to process)") "* %? %U :clojure:")
        ("bh" "haskell" entry (file+olp (concat org-inventory-dir "/review/browser-tabs.org") "firefox tabs" "haskell") "* %? %U :haskell:")
        ("l" "links" entry (file (concat org-dir "/links.org")) "* %? %U :links:send:")
        ("g" "github" entry (file (concat org-inventory-dir "/checklists/github.org")) "* %? %U :github:")
        ("k" "knowledge base" entry (file (concat org-inventory-dir "/kb.org")) "* %? %U :kb:raw:")
        ("s" "search" entry (file (concat org-inventory-dir "/search.org")) "* TODO %? %U :search:")
        ("n" "newspaper articles" entry (file+headline (concat org-dir "/checklists/from_newspapers.org") "unsorted") "* %? %U :newspaper:toread:")
        )))

;#############################################################################
;#   Setup
;############################################################################
(appt-activate t)
(run-at-time "00:59" 3600 'org-save-all-org-buffers)
(load (concat config-basedir "last-scrum-timestamp"))

;#############################################################################
;#   Hooks
;############################################################################
(defun custom/org-mode-hook ()
  (local-set-key (kbd "C-x C-a") 'show-all)
  (local-unset-key (kbd "C-c ["))
  (local-unset-key (kbd "C-c ]"))
  (local-unset-key (kbd "C-c C-o"))
  (local-set-key (kbd "C-c C-o C-l") 'browse-url-at-point)
  (imenu-add-to-menubar "Imenu"))

(add-hook 'org-mode-hook 'custom/org-mode-hook)
(add-hook 'org-mode-hook 'turn-on-font-lock)
(add-hook 'diary-display-hook 'fancy-diary-display)
(add-hook 'org-after-todo-state-change-hook 'custom/org-todo-changed-hook)
(add-hook 'org-clock-out-hook 'custom/remove-empty-drawer-on-clock-out 'append)

;#############################################################################
;#   Keybindings
;############################################################################
(global-set-key (kbd "C-c e") 'org-capture)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-iswitchb)
(global-set-key (kbd "C-c t c") 'org-table-create)
(global-set-key (kbd "C-c t s") 'org-sparse-tree)
(global-set-key (kbd "C-c t t") 'org-toggle-timestamp-type)
(global-set-key (kbd "C-c t t") 'org-toggle-timestamp-type)
(global-set-key (kbd "C-c o") 'oog)
(global-set-key (kbd "C-c m m") 'org-agenda-bulk-mark-all)
(global-set-key (kbd "C-c m u") 'org-agenda-bulk-unmark-all)
(global-set-key (kbd "<f12>") 'org-pomodoro)

(global-set-key (kbd "C-c C-o C-s") 'save-last-scrum-timestamp)
(global-set-key (kbd "C-c C-o C-m") 'mark-with-finished-timestamp)
(global-set-key (kbd "C-c C-o C-d") 'refile-job-done)

(provide 'rc-org-mode)

;;; emacs-rc-org-mode.el ends here
