;; Configure Org

;; [[https://orgmode.org/][Org Mode]] is the powerful task management, calendar, agenda, publishing system, and code documentation tool all-in-one that really extends the power of Emacs. I use Org Mode for the following:

;; - Organizing my tasks and projects similar to [[https://gettingthingsdone.com/][David Allen's "Getting Things Done"]] method
;; - Publishing \LaTeX{} documents quicker and more easily
;; - Coding using [[https://en.wikipedia.org/wiki/Literate_programming#:~:text=Literate%20programming%20is%20a%20programming%20paradigm%20introduced%20by,which%20compilable%20source%20code%20can%20be%20generated.%20][literate programming]].
  

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
  (org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)
  (org-directory "~/Nextcloud/org")
  (org-agenda-start-on-weekday nil)
  (org-agenda-files `("~/org"))
  (org-default-notes-file (concat org-directory "/inbox.org"))
  (org-refile-targets '((org-agenda-files :maxlevel . 3)))
  (org-refile-use-outline-path 'file)
  (org-outline-path-complete-in-steps nil)
  (org-refile-allow-creating-parent-nodes 'confirm)
  (org-export-in-background t)
  (org-log-into-drawer t)
  (org-todo-keywords
   '((sequence "TODO(t)"
               "WAITING(w)"
               "|"
               "DONE(d)"
               "CANCELED(c)")
     (sequence "MAYBE(m)"
               "SOMEDAY(s)"
               "PLANNING(p)"
               "|"
               "PLANNED(P)")
      (sequence "SCRIPTING(S)"
                "TESTING(G)"
                "REVIEW(R)"
                "APPROVAL(A)"
                "|"
                "EFFECTIVE(E)")))
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
  (org-capture-templates
   '(("f" "Future Reminders")
     ("c" "Calendar Entries")
     ("t" "To Do Items")
     ("p" "Projects item"
      entry
      (file "~/org/projects.org")
      "* %? :project:")
     ("fs" "Someday/Maybe Item"
      entry
      (file "~/org/someday.org")
      "* %?\n%x")
     ("ft" "Tickler file item"
      entry
      (file "~/org/tickler.org")
      "* %?\n%^{Scheduled}t\n\n%x")
     ("th" "Habit Item"
      entry
      (file+headline "~/org/inbox.org" "Habits")
      "* TODO %^{Title} %^G\n:PROPERTIES:\n:STYLE: habit\n:END:")
     ("tt" "Unscheduled TODO"
      entry
      (file+headline "~/org/inbox.org" "Tasks")
      "* TODO %^{Title} %^G\n\n%x")
     ("ts" "Scheduled TODO"
      entry
      (file+headline "~/org/inbox.org" "Tasks")
      "* TODO %^{Title} %^G\nSCHEDULED: %^{Scheduled}t\n\n%x")
     ("td" "Deadline TODO"
      entry
      (file+headline "~/org/inbox.org" "Tasks")
      "* TODO %^{Title} %^G\nSCHEDULED: %^{Scheduled}t DEADLINE: %^{Deadline}t\n%x")
     ("cw"
      "Work Calendar"
      entry
      (file+olp+datetree "~/org/work-calendar.org")
      "* %^{Title}\n%^{LOCATION|Virtual}p\n<%(org-read-date t nil org-read-date-final-answer)>\n")
     ("cp"
      "Personal Calendar"
      entry
      (file+olp+datetree "~/org/personal-calendar.org")
      "* %^{Title}\n%^{LOCATION}p\n<%(org-read-date t nil org-read-date-final-answer)>\n")
     ("r" "Periodic Reflections")
     ("rd" "Daily Enty"
      entry
      (file+olp+datetree "~/org/reflection/daily.org")
      "* Daily Gratitude\n\n- I am grateful for %^{Gratitude}\n\n* Daily Affirmation\n\n%^{Affirmation}\n\n* Daily Goal\n\n%^{Today's Goal}")
     ("rw" "Week Begin"
      entry
      (file+olp+datetree "~/org/reflection/weekly.org")
      "* Weekly Goal\n\n- :Goal: %^{Goal}\n- :Reward: %^{Reward}\n\n* Weekly Priorities\n\n1. %^{1st Priority}\n2. %^{2nd Priority}\n3. %^{3rd Priority}\n\n* Exicted About\n1. %^{Excited About 1}\n2. %^{ Excited About 2}\n3. %^{Excited About 3}"
      :tree-type week)
     ("rw" "Week End"
      entry
      (file+olp+datetree "~/org/reflection/weekly.org")
      "* Reflection\n** Lessons Learned\n\n1. %^{1st Lesson}\n2. %^{2nd Lesson}\n3. %^{3rd Lesson}\n** This Week's Wins\n\n1. %^{1st Win}\n2. %^{2nd Win}\n3. %^{3rd Win}\n** Improvments for Next Week\n1. %^{1st Improvement}\n2. %^{2nd Improvement}\n3. %^{3rd Improvement}"
      :tree-type week)))
  (org-modules '(ol-bbdb
                 ol-bibtex
                 ol-docviewol-doi
                 ol-eww
                 ol-gnus
                 org-habit
                 org-id
                 ol-info
                 org-inlinetask
                 ol-mhe
                 org-mouse
                 org-protocol
                 ol-rmail
                 ol-w3m
                 ol-eshell
                 org-annotate-file
                 ol-bookmark
                 org-checklist
                 org-choose
                 ol-eisp-symbol
                 org-notify org-toc))
  :config
  (add-hook 'org-mode-hook #'turn-on-flyspell)
  (add-hook 'org-mode-hook 'visual-line-mode)
  (with-eval-after-load "org"
    (add-to-list 'org-src-lang-modes '("plantuml" . plantuml)))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((awk . t)
     (C . t)
     (calc . t)
     (css . t)
     (dot . t)
     (emacs-lisp . t)
     (eshell . t)
     (gnuplot . t)
     (java . t)
     (latex . t)
     (ledger . t)
     (octave . t)
     (plantuml . t)
     (python . t)
     (R . t)
     (scheme . t)
     (sed . t)
     (shell . t)
     (sql . t)
     (sqlite . t))))

(use-package org-contrib
  :straight t
  :defer t
  :config
  (require 'ox-extra)
  (ox-extras-activate '(ignore-headlines)))

;; Org Header Sizes

;; The following custom function will change the heading sizes in Org Mode to make it easier to see the different heading levels. In addition, this will also increase the size of the document title and make it more prominent. This code is modified and from [[https://github.com/daviwil][@daviwil]] from [[https://github.com/daviwil/emacs-from-scratch/blob/master/show-notes/Emacs-05.org#improving-the-look][this link]].

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

;; End

;; Tell Emacs what feature this file provides.

(provide 'freemacs-org)

;;; freemacs-org.el ends here
