(let ((file-name-handler-alist nil))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Fix TLS issue in old Emacs versions
(if (>= 26.3 (string-to-number emacs-version))
    (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))

(require 'package)
(custom-set-variables '(package-archives
                        '(("melpa" . "https://melpa.org/packages/")
                          ("elpa" . "https://elpa.gnu.org/packages/")
                          ("org" . "http://orgmode.org/elpa/"))))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Check to see if use-package is installed
(unless (package-installed-p
         'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; use-package for managing emacs packages
(eval-when-compile
  (require 'use-package))

(use-package benchmark-init
  :disabled t
  :ensure t
  :hook
  ;; To disable collection of benchmark data after init is done.
  (after-init . benchmark-init/deactivate))

(add-hook 'before-save-hook 'time-stamp)

(prefer-coding-system 'utf-8)
(when (display-graphic-p)
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))

;; Send deleted files to the system's trash
(setq delete-by-moving-to-trash t)

;; Version Control
(setq version-control t)
(setq delete-old-versions t)
(setq vc-make-backup-files t)

;; Only y or n instead of yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;; Sentences end with a single space
(setq sentence-end-double-space nil)

(use-package all-the-icons
  :if (and window-system (not (file-exists-p "~/runemacs.bat")))
  :ensure t)

(use-package all-the-icons-dired
    :if (and window-system (not (file-exists-p "~/runemacs.bat")))
    :ensure t
    :hook
    (dired-mode . all-the-icons-dired-mode))

(use-package all-the-icons-ibuffer
  :if (and window-system (not (file-exists-p "~/runemacs.bat")))
  :ensure t
  :init (all-the-icons-ibuffer-mode 1))

  (use-package all-the-icons-ivy-rich
  :if (and window-system (not (file-exists-p "~/runemacs.bat")))
  :ensure t
  :config
  (all-the-icons-ivy-rich-mode 1))

(use-package spacemacs-theme
  :if window-system
  :ensure t
  :defer t
  :init (load-theme 'spacemacs-dark t))

(use-package spaceline
  :if window-system
  :ensure t
  :config  
  (require 'spaceline-config)
  (spaceline-emacs-theme))

(use-package spaceline-all-the-icons
  :disabled t
  :if window-system
  :ensure t
  :after spaceline
  :config
  (setq spaceline-all-the-icons-separator-type 'arrow)
  (spaceline-all-the-icons-theme)
  (spaceline-all-the-icons--setup-anzu)            ;; Enable anzu searching
  (spaceline-all-the-icons--setup-package-updates) ;; Enable package update indicator
  (spaceline-all-the-icons--setup-git-ahead)       ;; Enable # of commits ahead of upstream in git
  (spaceline-all-the-icons--setup-paradox)         ;; Enable Paradox mode line
  (spaceline-all-the-icons--setup-neotree))         ;; Enable Neotree mode line

;;Display Time
(display-time-mode 1)

(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)

(use-package nyan-mode
  :if window-system
  :ensure t
  :commands nyan-mode
  :config
  (setq nyan-wavy-trail t))

(use-package numpydoc
  :ensure t
  :bind (:map python-mode-map
              ("C-c C-n" . numpydoc-generate)))

(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable)
  :custom
  (elpy-rpc-python-command "python3")
  (python-shell-interpreter "ipython")
  (python-shell-interpreter-args "-i --simple-prompt")
  (elpy-formatter 'black)
  :config
  ;; Check python syntax while writing with flycheck
  (when (load "flycheck" t t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode)))

(add-hook 'elpy-mode-hook (lambda ()
                            (add-hook 'before-save-hook
                                      'elpy-black-fix-code nil t)))

(use-package flycheck
  :ensure t
  :defer t)

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

(setq show-paren-delay 0)
(show-paren-mode 1)

(use-package company               
  :ensure t
  :defer t
  :init (global-company-mode))
;; Documentation popups for Company
(use-package company-quickhelp
  :ensure t
  :defer t
  :init (add-hook 'global-company-mode-hook #'company-quickhelp-mode))
;; Add autocompletion for python
(use-package company-anaconda
  :ensure t
  :defer t)
;; Add autocompletion for AUCTeX
(use-package company-auctex
 :ensure t
 :defer t)
;; Add autocompletion for Ledger
(use-package company-ledger
 :ensure t
 :defer t)
;; Add autocompletion for org-mode blocks
(use-package company-org-block
 :ensure t
 :defer t)

(use-package bbdb
  :ensure t
  :defer t
  :hook
  (gnus-summary-mode . (lambda ()
                         (define-key gnus-summary-mode-map (kbd ";") 'bbdb-mua-edit-field)))
  :custom
  (bbdb-file "~/Dropbox/bbdb")
  (bbdb-use-pop-up 'horiz)
  :config
  (bbdb-mua-auto-update-init 'gnus 'message)
  (setq bbdb-mua-update-interactive-p '(query . create))
  ;; Look at every address in a message, not just the first
  (setq bbdb-message-all-addresses t))

(use-package deft
  :after org
  :defer t
  :bind
  ("C-c n d" . deft)
  :commands (deft)
  :custom
  (deft-recursive t)
  (deft-use-filter-string-for-filename t)
  (deft-default-extension "org")
  (deft-directory "~/Dropbox/org-roam/")
  (deft-strip-summary-regexp ":PROPERTIES:\n\\(.+\n\\)+:END:\n")
  (deft-use-filename-as-title t))

;; Copy files from one pane to another
(setq dired-dwim-target t)

(use-package dired+
  ;; Only use dired+ if used on a Windows device as vanilla dired works just find on any other OS
  :if (memq window-system '(w32 pc ns))
  :defer t
  :load-path "~/.emacs.d/elisp")

(use-package docker
  :ensure t
  :bind ("C-c d" . docker))

(use-package docker-compose-mode
  :ensure t)

(use-package eshell
  :defer t
  :hook
  (eshell-mode . (lambda ()
                   ;; Run interactive shell commands in the Emacs ansi-term
                   (add-to-list 'eshell-visual-commands "htop")
                   (add-to-list 'eshell-visual-commands "ipython")
                   (add-to-list 'eshell-visual-commands "rclone")
                   (add-to-list 'eshell-visual-commands "ssh")
                   (add-to-list 'eshell-visual-commands "tail")
                   (add-to-list 'eshell-visual-commands "top")
                   ;; Set aliases for commands in eshell
                   (eshell/alias "ff" "find-file $1")
                   (eshell/alias "emacs" "find-file $1")
                   (eshell/alias "untar" "tar -zxvf")
                   (eshell/alias "cpv" "rsync -ah --info=progress2")
                   (eshell/alias "ll" "ls -AlohG")))
  :config
  (setq eshell-error-if-no-glob t
        ;; Ignore duplicate history entries
        eshell-hist-ignoredups t
        eshell-save-history-on-exit t
        eshell-destroy-buffer-when-process-dies t)
  (setenv "PAGER" "cat"))

(use-package em-smart
  :defer t
  :custom
  (eshell-smart-space-goes-to-end t)
  (eshell-where-to-jump 'begin)
  (eshell-review-quick-commands nil))

;; Do not use a pager in Eshell because Emacs can do the paging

(setq eshell-prompt-function
      (lambda ()
        (concat
         (propertize "┌─[" 'face `(:foreground "green"))
         (propertize (user-login-name) 'face `(:foreground "red"))
         (propertize "@" 'face `(:foreground "green"))
         (propertize (system-name) 'face `(:foreground "blue"))
         (propertize "]──[" 'face `(:foreground "green"))
         (propertize (format-time-string "%H:%M" (current-time)) 'face `(:foreground "yellow"))
         (propertize "]──[" 'face `(:foreground "green"))
         (propertize (concat (eshell/pwd)) 'face `(:foreground "white"))
         (propertize "]\n" 'face `(:foreground "green"))
         (propertize "└─>" 'face `(:foreground "green"))
         (propertize (if (= (user-uid) 0) " # " " $ ") 'face `(:foreground "green"))
         )))

(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

(setq gnus-init-file "~/.emacs.d/gnus.el")

(use-package gnuplot
  :ensure t
  :defer t)
(use-package gnuplot-mode
  :ensure t
  :defer t)

(use-package ibuffer
  :defer t
  :bind
  ("C-x C-b" . ibuffer)
  :hook
  ;; Start ibuffer with default groupings
  (ibuffer-mode .  (lambda ()
                          (ibuffer-switch-to-saved-filter-groups "default")))
  :config
  ;; Create default groupings for ibuffer
  (setq ibuffer-saved-filter-groups
        (quote (("default"
                 ("Dired" (mode . dired-mode))
                 ("Emacs" (or
                           (name . "^\\*scratch\\*$")            
                           (name . "^\\*Messages\\*$")
                           (name . "^\\*GNU Emacs\\*$")
                           (name . "^\\*Help\\*$")
                           (name . "^\\*Calendar\\*$")
                           (name . "^\\*Calculator\\*$")
                           (name . "^\\*Calc Trail\\*$")
                           (name . "^\\*Completions\\*$")))
                 ("Gnus" (or
                          (mode . message-mode)
                          (mode . bbdb-mode)
                          (mode . mail-mode)
                          (mode . gnus-group-mode)
                          (mode . gnus-summary-mode)
                          (mode . gnus-article-mode)
                          (name . "^\\.bbdb$")
                          (name . "^\\.newsrc-dribble")))
                 ("Org"   (or
                           (mode . org-mode)
                           (name . "^\\*Org Agenda\\*$")))
                 ("Shell"   (or
                             (mode . eshell)
                             (mode . term)
                             (mode . shell))))))))

(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) "))

(use-package counsel
  :bind
  ("M-x" . counsel-M-x)
  ("C-x C-f" . counsel-find-file)
  :ensure t
  :config
  (counsel-mode))

(use-package swiper
  :bind
  ("C-s" . swiper)
  :ensure t)

(use-package ivy-rich
  :ensure t
  :after counsel
  :config
  (ivy-rich-mode 1)
  (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line))

(use-package tex
  :defer t
  :ensure auctex
  :custom
  (TeX-auto-save t)
  (TeX-parse-self t)
  (TeX-master nil))

(setq bibtex-dialect 'biblatex)

(use-package ledger-mode
  :ensure t
  :defer t)

;; Turn on multiple cursors for editing multiple points at the same time.
(use-package multiple-cursors
  :ensure t
  :defer t
  :bind
  ("C-S-c C-S-c" . 'mc/edit-lines)
  ("C->" . 'mc/mark-next-like-this)
  ("C-<" . 'mc/mark-previous-like-this)
  ("C-c C-<" . 'mc/mark-all-like-this))

(custom-set-variables '(org-agenda-files
                        `("~/Dropbox/gtd")))

(use-package org
  :mode (("\\.org$" . org-mode))
  :bind
  ("C-c c" . org-capture)
  ("C-c a" . org-agenda)
  (:map org-mode-map
        ("C-c l" . org-store-link))
  :ensure org-plus-contrib
  :hook (org-mode . turn-on-flyspell)
  :custom

  ;; Show org-mode the default directory in which to keep org-mode files
  (org-directory "~/Dropbox/gtd")

  ;; Start all emacs org-mode buffers with "clean-view" turned on. This makes it easier to see and read org-mode files.
  (org-startup-indented t)

  ;; Change the color of the org-todo keywords to make it easier to see them on a color screen and distinguish between them.
  (org-todo-keyword-faces
        '(("TODO" . org-warning)
          ("WAITING" . "yellow")
          ("CANCELED" . (:foreground "blue" :weight bold))
          ("DONE" . org-done)))

  ;; Keep only a single space between the headline and the tag
  (org-tags-column 0)

  ;; Don't inherit project tags
  (org-tags-exclude-from-inheritance '("project"))

  ;; This will allow for source code blocks in emacs org-mode to be internally indented to clean up the code.
  (org-src-tab-acts-natively t)

  ;; Place all notes captured that are not filed into the default inbox file
  (org-default-notes-file (concat org-directory "/inbox.org"))

  ;; In order to refile/move tasks from the inbox to other agenda files and subtrees, the following must be set:
  (org-refile-targets '((org-agenda-files :maxlevel . 3)))

  ;; The following will allow for refiling org-mode tasks at the top of a file.
  ;; Setting this will also require turning off completing the path in steps if ivy-mode autocompletiion is used.
  (org-refile-use-outline-path 'file)
  (org-outline-path-complete-in-steps nil)

  ;; Setting this variable allows for refiling tasks under a new heading on the fly
  (org-refile-allow-creating-parent-nodes (quote confirm))

  ;; Define a stuck project as any headline with the project keyword which has no TODO item below it.
  (org-stuck-projects
   '("+project/-MAYBE-DONE" ("NEXT" "TODO") nil "\\<IGNORE\\>"))

  ;; Set up the sequence of org-todo task keywords to allow for delegated(WAITING) tasks and CANCELLED tasks.
  (org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

  ;; Use biblatex instead of bibtex
  (org-latex-pdf-process
    '("pdflatex -interaction nonstopmode -output-directory %o %f"
      "biber %b"
      "pdflatex -interaction nonstopmode -output-directory %o %f"
      "pdflatex -interaction nonstopmode -output-directory %o %f"))

  :config

  ;; Wrap lines at window edge in org-mode
  (add-hook 'org-mode-hook #'toggle-truncate-lines)

  ;; Load languages to use in org-babel
  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
  (org-babel-do-load-languages 'org-babel-load-languages
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
                                 (sed . t)
                                 (shell . t)))
  ;; This package will allow for the use of the :ignore: tag that can be used to remove headers from exported content.
  (require 'ox-extra)
  (ox-extras-activate '(ignore-headlines)))

(use-package org-bullets
  :if window-system
  :ensure t
  :after org
  :hook
  (org-mode . (lambda () (org-bullets-mode 1))))

(use-package calfw
  :disabled t
  :ensure t
  :config
  (setq cfw:fchar-junction ?╋
        cfw:fchar-vertical-line ?┃
        cfw:fchar-horizontal-line ?━
        cfw:fchar-left-junction ?┣
        cfw:fchar-right-junction ?┫
        cfw:fchar-top-junction ?┯
        cfw:fchar-top-left-corner ?┏
        cfw:fchar-top-right-corner ?┓))

(use-package calfw-org
  :disabled t
  :ensure t
  :requires calfw
  :config
  (defalias 'calfworg 'cfw:open-org-calendar))

(use-package org-agenda
    :ensure nil
    :after org
    :custom
    (org-agenda-start-on-weekday nil))

(use-package org-capture
:ensure nil
:after org
:config
;; Set the default org-capture-templates to make creating an org-headline quick and easy
(setq org-capture-templates
      '(("p" "Projects item" entry (file "~/Dropbox/gtd/projects.org")
         "* %? :project:")
        ("s" "Someday/Maybe item" entry (file "~/Dropbox/gtd/someday.org")
         "* %?\n%x")
        ("T" "Tickler file item" entry (file "~/Dropbox/gtd/tickler.org")
         "* %?\n%^{Scheduled}t\n%x")
        ("t" "To Do Item" entry (file+headline "~/Dropbox/gtd/inbox.org" "Tasks")
         "* TODO %? %^G\nSCHEDULED: %^{Scheduled}t DEADLINE: %^{Deadline}t\n%x"))))

(use-package org-download
  :after org
  :bind
  (:map org-mode-map
        (("s-Y" . org-download-screenshot)
         ("s-y" . org-download-yank))))

;; This is an Emacs package that creates graphviz directed graphs from
;; the headings of an org file
(use-package org-mind-map
  :ensure t
  :after org
  :commands org-mind-map-write
  :init
  (require 'ox-org)
  ;; Uncomment the below if 'ensure-system-packages` is installed
  ;;:ensure-system-package (gvgen . graphviz)
  :custom
  (org-mind-map-engine "dot")       ; Default. Directed Graph
  ;; (org-mind-map-engine "neato")  ; Undirected Spring Graph
  ;; (org-mind-map-engine "twopi")  ; Radial Layout
  ;; (org-mind-map-engine "fdp")    ; Undirected Spring Force-Directed
  ;; (org-mind-map-engine "sfdp")   ; Multiscale version of fdp for the layout of large graphs
  ;; (org-mind-map-engine "twopi")  ; Radial layouts
  ;; (org-mind-map-engine "circo")  ; Circular Layout
  )

(use-package org-ref
  :ensure t
  :defer t
  :after org)

;; Org-Roam basic configuration
;;(setq org-directory (concat (getenv "HOME") "/Dropbox/org-roam/"))

(use-package org-roam
  :ensure t
  :defer t
  :after org
  :init
  (setq org-roam-v2-ack t) ;; Acknowledge V2 upgrade
  :custom
  (org-roam-directory (file-truename "~/Dropbox/org-roam"))
  :config
  (org-roam-setup)
  (setq org-roam-dailies-directory "daily/")
  (setq org-roam-capture-templates
    '(("d" "default" plain "%?"
       :target (file+head "${slug}.org"
       "#+title: ${title}\n")
       :unnarrowed t)))
  (setq org-roam-dailies-capture-templates
    '(("d" "default" entry
       "* %?"
       :target (file+head "%<%Y-%m-%d>.org"
                          "#+title: %<%Y-%m-%d>\n"))))
  :bind (("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n r" . org-roam-node-random)		    
         (:map org-mode-map
               (("C-c n i" . org-roam-node-insert)
                ("C-c n o" . org-id-get-create)
                ("C-c n t" . org-roam-tag-add)
                ("C-c n a" . org-roam-alias-add)
                ("C-c n l" . org-roam-buffer-toggle)))))

(use-package pdf-tools
  :ensure t
  :magic ("%PDF" . pdf-view-mode)
  :config
  (pdf-loader-install :no-query))

(setq org-plantuml-jar-path (expand-file-name "~/.emacs.d/plantuml/plantuml.jar"))

(use-package plantuml-mode
  :ensure t
  :defer t
  :after org)

(use-package which-key
  :ensure t
  :config
  ;; Type C-h during any key combination to pop-up which key
  (setq which-key-show-early-on-C-h t)
  ;; Use the <f4> key in any major mode to see the key bindings
  (global-set-key (kbd "<f4>") 'which-key-show-major-mode)
  (which-key-mode)
  ;; Set up which-key to use the side window preferrably
  (which-key-setup-side-window-right-bottom))

(setq gc-cons-threshold (* 2 1000 1000))
)

(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))
