;; Configure Org

;; Set up configuration for buit-in Org Mode.  

(use-package org
  :straight (:type built-in)
  :defer t
  :init
  (setq org-capture-templates nil)
  (whicher "pdflatex")
  (whicher "biber")
  :bind
  ("C-c l" . #'org-store-link)
  ("C-c a" . #'org-agenda)
  ("C-c c" . #'org-capture)
  :custom
  (org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)
  (org-directory "~/org")
  (org-agenda-start-on-weekday nil)
  (org-agenda-files `("~/org/agenda"))
  (org-default-notes-file (concat org-directory "/notes/notes.org"))
  (org-refile-targets `((org-agenda-files :maxlevel . 4)
                        (,(concat org-directory "/notes") :maxlevel . 3)))
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
     (sqlite . t)))
  (mapc 'load (file-expand-wildcards "~/.emacs.d/org-templates/*.el")))

(use-package org-contrib
  :straight t
  :defer t
  :config
  (require 'ox-extra)
  (ox-extras-activate '(ignore-headlines)))

;; Automatically Mark Parents as Done When All Children Are Done 

;; For headers with subtasks, automatically mark the header as completed when all the subtasks are complete.

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (org-todo (if (= n-not-done 0) "DONE" "TODO")))

(add-hook 'org-after-todo-statistics-hook #'org-summary-todo)

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
