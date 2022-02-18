;; -*- lexical-binding: t -*-
;; 
;;; init.el --- Emacs initialization file

;; Author: Thomas Freeman
;; Maintainer: Thomas Freeman
;; Created: 09 Jan 2022

;; URL: https://github.com/tfree87/.emacs.d

;; This file is an init file for Emacs.
;; This file IS NOT intended to be edited! It was generated by init.org.

;; For documentation and for editing this file, see the init.org in the
;; github repository tfree87/.emacs.d
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(let ((file-name-handler-alist nil))

(when (file-exists-p "~/runemacs.bat")
    (add-to-list 'exec-path "~/PortableApps/GitPortable/App/Git/bin"))

;; Set the location of variables set using Emacs cusmtomize interface

(setq custom-file "~/.emacs.d/custom.el")

;; Load the file custom.el file containing variables from Emacs customize

(load custom-file)

;; Install Straight.el to manage packages by downloading directly from repositories

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Packages

(straight-use-package 'use-package)

(use-package benchmark-init
  :straight t
  :config
  (benchmark-init/activate)
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

(use-package no-littering
  :straight (no-littering :host github
                          :repo "emacscollective/no-littering"
                          :branch "master"))

(use-package emacs
  :custom
  (inhibit-startup-screen t)
  (tab-always-indent 'complete)
  (completion-cycle-threshold 6)
  (delete-by-moving-to-trash t)
  (version-control t)
  (delete-old-versions t)
  (vc-make-backup-files t)
  (sentence-end-double-space nil)
  (dired-dwim-target t)
  :config
  (when (version<= "26.0.50" emacs-version)
    (add-hook 'text-mode-hook 'display-line-numbers-mode)
    (add-hook 'prog-mode-hook 'display-line-numbers-mode))
  (column-number-mode 1)
  (add-hook 'before-save-hook 'time-stamp)
  (fset 'yes-or-no-p 'y-or-n-p)
  (display-time-mode 1)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (toggle-scroll-bar -1))

(use-package all-the-icons
  :if (not (file-exists-p "~/runemacs.bat"))
  :defer 1
  :straight t)

(use-package all-the-icons-dired
  :if (not (file-exists-p "~/runemacs.bat"))
  :straight t
  :hook
  (dired-mode . all-the-icons-dired-mode))

(use-package all-the-icons-ibuffer
  :if (not (file-exists-p "~/runemacs.bat"))
  :straight t
  :hook (ibuffer-mode . all-the-icons-ibuffer-mode))

(use-package all-the-icons-completion
  :if (not (file-exists-p "~/runemacs.bat"))
  :straight t
  :defer 3
  :config
  (all-the-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup))

(use-package doom-themes
  :if window-system
  :straight t
  :defer 1
  :config
  (load-theme 'doom-vibrant t)
  (doom-themes-org-config))

(use-package doom-modeline
  :if window-system
  :straight t
  :defer 1
  :config (doom-modeline-mode))

(use-package nyan-mode
  :if window-system
  :straight t
  :defer 3
  :delight
  :custom
  (nyan-wavy-trail t)
  :config
  (nyan-mode)
  (nyan-start-animation))

(use-package ace-window
  :straight t
  :bind ("M-o" . ace-window))

(use-package corfu
  :straight t
  :custom
  (corfu-cycle t)
  (corfu-preselect-first nil)
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous))
  :init
  (corfu-global-mode)
  :config
  (defun corfu-enable-in-minibuffer ()
    "Enable Corfu in the minibuffer if `completion-at-point' is bound."
    (when (where-is-internal #'completion-at-point (list (current-local-map)))
      (corfu-mode 1)))
  (add-hook 'minibuffer-setup-hook #'corfu-enable-in-minibuffer)
  (add-hook 'eshell-mode-hook
            (lambda ()
              (setq-local corfu-quit-at-boundary t
                          corfu-quit-no-match t
                          corfu-auto nil)
              (corfu-mode)))
  
  ;; Silence the pcomplete capf, no errors or messages!
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-silent)
  
  ;; Ensure that pcomplete does not write to the buffer
  ;; and behaves as a pure `completion-at-point-function'.
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-purify))

(use-package corfu-doc
  :straight (corfu-doc :host github
                       :repo "galeo/corfu-doc"
                       :branch "main")
  :hook
  (corfu-mode . corfu-doc-mode)
  :config
  (define-key corfu-map (kbd "M-p") #'corfu-doc-scroll-down)
  (define-key corfu-map (kbd "M-n") #'corfu-doc-scroll-up))

(use-package cape
  :straight t
  :bind (("C-c p p" . completion-at-point)
         ("C-c p t" . complete-tag)
         ("C-c p d" . cape-dabbrev)
         ("C-c p f" . cape-file)
         ("C-c p k" . cape-keyword)
         ("C-c p s" . cape-symbol)
         ("C-c p a" . cape-abbrev)
         ("C-c p \\" . cape-tex)
         ("C-c p _" . cape-tex)
         ("C-c p ^" . cape-tex))
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-tex)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  (add-to-list 'completion-at-point-functions #'cape-symbol))

(defun sudo-find-file (file)
  "Open FILE as root."
  (interactive "FOpen file as root: ")
  (when (file-writable-p file)
    (user-error "File is user writeable, aborting sudo"))
  (find-file (if (file-remote-p file)
                 (concat "/" (file-remote-p file 'method) ":"
                         (file-remote-p file 'user) "@" (file-remote-p file 'host)
                         "|sudo:root@"
                         (file-remote-p file 'host) ":" (file-remote-p file 'localname))
               (concat "/sudo:root@localhost:" file))))

(use-package embark
  :straight t
  :bind
  (("C-." . embark-act)
   ("C-;" . embark-dwim)
   ("C-h B" . embark-bindings))
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none))))
  (define-key embark-file-map (kbd "S") 'sudo-find-file))

(use-package embark-consult
  :straight t
  :after (embark consult)
  :demand t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package vertico
  :straight t
  :demand t
  :custom
  (vertico-cycle t)
  (vertico-resize t)
  :init
  (vertico-mode))

(use-package orderless
  :straight t
  :defer 5
  :custom
  (completion-styles '(orderless))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package savehist
  :straight t
  :init
  (savehist-mode))

(use-package marginalia
  :straight t
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

(use-package aggressive-indent
  :straight t
  :delight t
  :hook
  (prog-mode . aggressive-indent-mode)
  :config
  (add-to-list 'aggressive-indent-excluded-modes 'html-mode))

(use-package apheleia
  :straight t
  :hook
  (prog-mode . apheleia-mode)
  (tex-mode . apheleia-mode)
  :config
  (setf (alist-get 'black apheleia-formatters)
  '("black" "--experimental-string-processing" "-")))

(use-package c-mode
  :defer t
  :mode ("\\.c\\'"
         "\\.ino\\'"))

(use-package elpy
  :straight t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable)
  :custom
  (elpy-rpc-python-command "python3")
  (python-shell-interpreter "ipython3")
  (python-shell-interpreter-args "-i --simple-prompt")
  :config
  (when (load "flycheck" t t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode)))

(use-package flycheck
  :straight t
  :defer t)

(use-package go-mode
  :straight t
  :defer t)

(use-package magit
  :if (executable-find "git")
  :straight t
  :bind ("C-x g" . magit-status))

(use-package numpydoc
  :straight t
  :bind (:map python-mode-map
              ("C-c C-n" . numpydoc-generate)))

(use-package paren
  :delight
  :defer t
  :custom
  (show-paren-delay 0)
  :hook (prog-mode . show-paren-mode))

(use-package projectile
  :straight t
  :delight t
  :config
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map)))

(use-package consult
  :straight t
  :bind (("C-c h" . consult-history)
         ("C-c m" . consult-mode-command)
         ("C-c k" . consult-kmacro)
         ("C-x M-:" . consult-complex-command)
         ("C-x b" . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)
         ("C-x 5 b" . consult-buffer-other-frame)
         ("C-x r b" . consult-bookmark)
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)
         ("C-M-#" . consult-register)
         ("M-y" . consult-yank-pop)
         ("<help> a" . consult-apropos)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)
         ("M-g g" . consult-goto-line)
         ("M-g M-g" . consult-goto-line)
         ("M-g o" . consult-outline)
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s m" . consult-multi-occur)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)
         ("M-s e" . consult-isearch-history)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi))
  :init
  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Optionally replace `completing-read-multiple' with an enhanced version.
  (advice-add #'completing-read-multiple :override #'consult-completing-read-multiple)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :config
  (consult-customize
   consult-theme
   :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-recent-file consult--source-project-recent-file consult--source-bookmark
   :preview-key (kbd "M-."))
  (setq consult-narrow-key "<") ;; (kbd "C-+")
  (setq consult-project-root-function
        (lambda ()
          (when-let (project (project-current))
            (car (project-roots project))))))

(use-package bbdb
  :straight t
  :defer t
  :hook
  (gnus-summary-mode . (lambda ()
                         (define-key gnus-summary-mode-map (kbd ";") 'bbdb-mua-edit-field)))
  :custom
  (bbdb-file "~/Dropbox/bbdb")
  (bbdb-use-pop-up 'horiz)
  (bbdb-mua-update-interactive-p '(query . create))
  (bbdb-message-all-addresses t)
  :config
  (bbdb-mua-auto-update-init 'gnus 'message))

(use-package delight
  :straight t)

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

(use-package sunrise-commander
  :defer t
  :straight t)

(use-package docker
  :if (executable-find "docker")
  :straight t
  :bind ("C-c d" . docker))

(use-package docker-compose-mode
  :defer t
  :straight t)

(use-package eshell
  :defer t
  :hook
  (eshell-load . (lambda ()
                        (eshell-git-prompt-use-theme 'multiline2)))
  (eshell-mode . (lambda ()
                   (add-to-list 'eshell-visual-commands "htop")
                   (add-to-list 'eshell-visual-commands "ipython")
                   (add-to-list 'eshell-visual-commands "rclone")
                   (add-to-list 'eshell-visual-commands "ssh")
                   (add-to-list 'eshell-visual-commands "tail")
                   (add-to-list 'eshell-visual-commands "top")
                   (eshell/alias "ff" "find-file $1")
                   (eshell/alias "emacs" "find-file $1")
                   (eshell/alias "untar" "tar -zxvf")
                   (eshell/alias "cpv" "rsync -ah --info=progress2")
                   (eshell/alias "ll" "ls -Alh")))
  :custom
  (eshell-error-if-no-glob t)
  (eshell-hist-ignoredups t)
  (eshell-save-history-on-exit t)
  (eshell-destroy-buffer-when-process-dies t)
  :config
  
  (setenv "PAGER" "cat"))

(use-package eshell-git-prompt
  :straight (emacs-git-prompt :host github
                              :repo "tfree87/eshell-git-prompt"
                              :branch "master")
  :defer t)

(use-package eshell-toggle
  :straight (eshell-toggle :repo "4DA/eshell-toggle"
                           :host github
                           :repo "master")
  :custom
  (eshell-toggle-size-fraction 3)
  ;; (eshell-toggle-use-projectile-root t)
  (eshell-toggle-run-command nil)
  (eshell-toggle-init-function #'eshell-toggle-init-eshell)
  :bind
  ("M-s-`" . eshell-toggle))

(use-package flyspell
  :if (not (file-exists-p "~/runemacs.bat"))
  :delight t
  :defer t
  :config
  (add-hook 'text-mode-hook 'flyspell-mode)
  (add-hook 'prog-mode-hook 'flyspell-prog-mode))

(use-package gnus
  :defer t
  :custom
  (gnus-init-file "~/.emacs.d/gnus.el"))

(use-package gnuplot
  :if (executable-find "gnuplot")
  :straight t
  :defer t)
(use-package gnuplot-mode
  :straight t
  :defer t)

(use-package ibuffer
  :bind
  ("C-x C-b" . ibuffer)
  :hook
  ;; Start ibuffer with default groupings
  (ibuffer-mode .  (lambda ()
                          (ibuffer-switch-to-saved-filter-groups "default")))
  :custom
  (ibuffer-saved-filter-groups
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

(use-package auctex
  :straight t
  :defer t
  :custom
  (TeX-auto-save t)
  (TeX-parse-self t)
  (TeX-master nil))

(setq bibtex-dialect 'biblatex)

(use-package ledger-mode
  :straight t
  :defer t)

(use-package markdown-mode
  :straight t
  :mode ("\\.\\(m\\(ark\\)?down\\|md\\)$" . markdown-mode)
  :config
  (bind-key "A-b" (surround-text-with "+*") markdown-mode-map)
  (bind-key "s-b" (surround-text-with "**") markdown-mode-map)
  (bind-key "A-i" (surround-text-with "*") markdown-mode-map)
  (bind-key "s-i" (surround-text-with "*") markdown-mode-map)
  (bind-key "A-=" (surround-text-with "`") markdown-mode-map)
  (bind-key "s-=" (surround-text-with "`") markdown-mode-map))

(use-package multiple-cursors
  :straight t
  :defer t
  :bind
  ("C-S-c C-S-c" . 'mc/edit-lines)
  ("C->" . 'mc/mark-next-like-this)
  ("C-<" . 'mc/mark-previous-like-this)
  ("C-c C-<" . 'mc/mark-all-like-this))

(use-package org
  :straight t
  :mode (("\\.org$" . org-mode))
  :bind
  ("C-c c" . org-capture)
  ("C-c a" . org-agenda)
  (:map org-mode-map
        ("C-c l" . org-store-link))
  :hook (org-mode . turn-on-flyspell)
  :custom
  (org-directory "~/Dropbox/gtd")
  (org-agenda-files
   `("~/Dropbox/gtd"))
  (org-default-notes-file (concat org-directory "/inbox.org"))
  (org-refile-targets '((org-agenda-files :maxlevel . 3)))
  (org-refile-use-outline-path 'file)
  (org-outline-path-complete-in-steps nil)
  (org-log-into-drawer t)
  (org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))
  (org-tags-exclude-from-inheritance '("project"))
  (org-stuck-projects
   '("+project/-MAYBE-DONE" ("NEXT" "TODO") nil "\\<IGNORE\\>"))
  (org-latex-pdf-process
   '("pdflatex -interaction nonstopmode -output-directory %o %f"
     "biber %b"
     "pdflatex -interaction nonstopmode -output-directory %o %f"
     "pdflatex -interaction nonstopmode -output-directory %o %f"))
  (org-tags-column 0)
  (org-startup-indented t)
  (org-src-tab-acts-natively t)
  (org-todo-keyword-faces
   '(("TODO" . org-warning)
     ("WAITING" . "yellow")
     ("CANCELED" . (:foreground "blue" :weight bold))
     ("DONE" . org-done)))
  (org-plantuml-jar-path (expand-file-name "~/.emacs.d/plantuml/plantuml.jar")) 
  :config
  (add-hook 'org-mode-hook #'toggle-truncate-lines)
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
                                 (shell . t))))

(use-package org-contrib
  :straight t
  :after org)

(use-package org-bullets
  :if window-system
  :straight t
  :after org
  :hook
  (org-mode . (lambda () (org-bullets-mode 1))))

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

(use-package org-agenda
    :ensure nil
    :after org
    :custom
    (org-agenda-start-on-weekday nil))

(use-package org-capture
  :ensure nil
  :after org
  :custom
  (org-capture-templates
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

(use-package org-mind-map
  :straight t
  :after org
  :commands org-mind-map-write
  :init
  (require 'ox-org)
  :custom
  (org-mind-map-engine "dot"))

(use-package org-ref
  :straight t
  :defer t
  :after org)

(use-package org-roam
  :straight t
  :defer t
  :after org
  :init
  (setq org-roam-v2-ack t) ;; Acknowledge V2 upgrade
  :custom
  (org-roam-directory (file-truename "~/Dropbox/org-roam"))
  :config
  (org-roam-setup)
  :custom
  (org-roam-dailies-directory "daily/")
  (org-roam-capture-templates
   '(("d" "default" plain "%?"
      :target (file+head "${slug}.org"
                         "#+title: ${title}\n")
      :unnarrowed t)))
  (org-roam-dailies-capture-templates
   '(("d" "default" entry
      "* %?"
      :target (file+head "%<%Y-%m-%d>.org"
                         "#+title: %<%Y-%m-%d>\n"))))
  :bind
  (("C-c n f" . org-roam-node-find)
   ("C-c n g" . org-roam-graph)
   ("C-c n r" . org-roam-node-random)		    
   (:map org-mode-map
         (("C-c n i" . org-roam-node-insert)
          ("C-c n o" . org-id-get-create)
          ("C-c n t" . org-roam-tag-add)
          ("C-c n a" . org-roam-alias-add)
          ("C-c n l" . org-roam-buffer-toggle)))))

(use-package pdf-tools
  :straight t
  :magic ("%PDF" . pdf-view-mode)
  :config
  (pdf-loader-install :no-query))

(use-package plantuml-mode
  :straight t
  :defer t
  :after org)

(use-package popper
  :straight t
  :bind (("C-`"   . popper-toggle-latest)
         ("M-`"   . popper-cycle)
         ("C-M-`" . popper-toggle-type))
  :init
  (setq popper-reference-buffers
        '("\\*Messages\\*"
          "\\*Embark Actions\\*"
          "Output\\*$"
          "\\*Async Shell Command\\*"
          help-mode
          compilation-mode))
  (popper-mode +1)
  (popper-echo-mode +1))

(use-package treemacs
  :straight t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (treemacs-load-theme "all-the-icons")
  (progn
    (setq treemacs-show-hidden-files               t
          treemacs-wide-toggle-width               60
          treemacs-width                           30
          treemacs-width-is-initially-locked       nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    (treemacs-resize-icons 22)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-projectile
  :after (treemacs projectile)
  :straight t)

(use-package treemacs-all-the-icons
  :after treemacs
  :straight t
  :config (treemacs-load-theme 'all-the-icons))

(use-package treemacs-magit
  :after (treemacs magit)
  :straight t)

(use-package centaur-tabs
  :if window-system
  :straight t
  :defer t
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward)
  :custom
  (centaur-tabs-set-bar 'over)
  (centaur-tabs-style "chamfer")
  :config
  (centaur-tabs-mode t))

(use-package tramp
  :defer t
  :config
  (eval-after-load 'tramp '(setenv "SHELL" "/bin/bash")))

(use-package which-key
  :straight t
  :defer 3
  :delight
  :custom
  (which-key-show-early-on-C-h t)
  :config
  (global-set-key (kbd "<f4>") 'which-key-show-major-mode)
  (which-key-setup-side-window-right-bottom)
  (which-key-mode))

(use-package yasnippet
  :straight t
  :delight t
  :defer 3
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :straight t
  :defer t)

(use-package minimap
  :straight t
  :defer t)

(use-package rainbow-delimiters
  :straight t
  :hook (prog-mode . rainbow-delimiters-mode))

;; (load-file"~/.emacs.d/elisp/oh-my-esh.el")

;; Start an Emacs server

(when (not (file-exists-p "~/runemacs.bat"))
  (server-start))

(setq gc-cons-threshold (* 2 1000 1000))
)
