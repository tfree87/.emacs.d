;; Organization/Time Management/Notes Configuration

(use-package calfw
  :straight (emacs-calfw :host github
                         :repo "zemaye/emacs-calfw"
                         :branch "master")
  :commands (cfw:open-calendar-buffer)
  :init
  (defalias 'calfw 'cfw:open-calendar-buffer)
  :custom
  (cfw:fchar-junction ?╋)
  (cfw:fchar-vertical-line ?┃)
  (cfw:fchar-horizontal-line ?━)
  (cfw:fchar-left-junction ?┣)
  (cfw:fchar-right-junction ?┫)
  (cfw:fchar-top-junction ?┯)
  (cfw:fchar-top-left-corner ?┏)
  (cfw:fchar-top-right-corner ?┓))

(use-package calfw-org
  :straight (emacs-calfw :host github
                         :repo "zemaye/emacs-calfw"
                         :branch "master")
  :commands (cfw:open-org-calendar)
  :init
  (defalias 'calfworg 'cfw:open-org-calendar))

(use-package org
  :straight (:type built-in)
  :defer t
  :init
  (whicher "pdflatex")
  (whicher "biber")
  :bind
  ("C-c l" . #'org-store-link)
  ("C-c a" . #'org-agenda)
  ("C-c c" . #'org-capture)
  :custom
  (org-directory "~/Nextcloud/org")
  (org-agenda-start-on-weekday nil)
  (org-agenda-files `("~/Nextcloud/org"))
  (org-default-notes-file (concat org-directory "/inbox.org"))
  (org-refile-targets '((org-agenda-files :maxlevel . 3)))
  (org-refile-use-outline-path 'file)
  (org-outline-path-complete-in-steps nil)
  (org-refile-allow-creating-parent-nodes (quote confirm))
  (org-export-in-background t)
  (org-log-into-drawer t)
  (org-todo-keywords
   '((sequence "TODO(t)"
               "WAITING(w)"
               "|" "DONE(d)"
               "CANCELED(c)")))
  (org-tags-exclude-from-inheritance '("project"))
  (org-stuck-projects
   '("+project/-MAYBE-DONE"
     ("NEXT" "TODO")
     nil
     "\\<IGNORE\\>"))
  (org-latex-pdf-process
   '("pdflatex -interaction nonstopmode -output-directory %o %f"
     "biber %b"
     "pdflatex -interaction nonstopmode -output-directory %o %f"
     "pdflatex -interaction nonstopmode -output-directory %o %f"))
  (org-hide-emphasis-markers t)
  (org-tags-column 0)
  (org-startup-indented t)
  (org-src-tab-acts-natively t)
  (org-todo-keyword-faces
   '(("TODO" . org-warning)
     ("WAITING" . "yellow")
     ("CANCELED" . (:foreground "blue" :weight bold))
     ("DONE" . org-done)))
  (org-capture-templates
   '(("p" "Projects item" entry (file "~/gtd/projects.org")
      "* %? :project:")
     ("s" "Someday/Maybe item" entry (file "~/gtd/someday.org")
      "* %?\n%x")
     ("T" "Tickler file item" entry (file "~/gtd/tickler.org")
      "* %?\n%^{Scheduled}t\n%x")
     ("t" "To Do Item" entry (file+headline "~/gtd/inbox.org" "Tasks")
      "* TODO %? %^G\nSCHEDULED: %^{Scheduled}t DEADLINE: %^{Deadline}t\n%x")))
  :config
  (add-hook 'org-mode-hook #'turn-on-flyspell)
  (add-hook 'org-mode-hook 'visual-line-mode)
  (with-eval-after-load "org"
    (add-to-list 'org-src-lang-modes '("plantuml" . plantuml)))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((awk . t)
     (calc . t)
     (css . t)
     (emacs-lisp . t)
     (eshell . t)
     (gnuplot . t)
     (dot . t)
     (latex . t)
     (ledger . t)
     (octave . t)
     (plantuml . t)
     (R . t)
     (scheme . t)
     (sed . t)
     (shell . t))))

(use-package org-contrib
  :straight t
  :defer t
  :config
  (require 'ox-extra)
  (ox-extras-activate '(ignore-headlines)))

(use-package org-mind-map
  :straight t
  :after org
  :commands org-mind-map-write
  :init
  (require 'ox-org)
  :custom
  (org-mind-map-engine "dot"))

(defun freemacs/org-header-formatting ()
  "Change the size of headers and titles in Org Mode buffers."
  (interactive)
  (with-eval-after-load 'org
    (dolist
        (face
         '((org-level-1 . 2.00)
           (org-level-2 . 1.75)
           (org-level-3 . 1.50)
           (org-level-4 . 1.25)
           (org-level-5 . 1.10)
           (org-level-6 . 1.10)
           (org-level-7 . 1.10)
           (org-level-8 . 1.10)
           (org-document-title . 2.25)))
      (set-face-attribute (car face) nil :height (cdr face)))))

(provide 'freemacs-org)

;;; freemacs-org.el ends here
