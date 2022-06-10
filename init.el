;;; init.el --- Emacs initialization file -*- lexical-binding: t -*-

;; Copyright (C) 2022 Thomas Freeman

;; Author: Thomas Freeman
;; Maintainer: Thomas Freeman
;; Keywords: lisp
;; Version: 0.0.1
;; Created: 09 Jan 2022

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This file is an init file for Emacs.
;; This file IS NOT intended to be edited! It was generated by init.org.

;;; URL: https://github.com/tfree87/.emacs.d

;; For documentation and for editing this file, see the init.org in the
;; github repository tfree87/.emacs.d
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Code:

(let ((file-name-handler-alist nil))

(when (string= (getenv "EMACS_PORTABLE") "Y")
  (add-to-list 'exec-path "~/PortableApps/GitPortable/App/Git/bin"))

;; Set the location of variables set using Emacs customize interface

(setq custom-file "~/.emacs.d/custom.el")

;; Load the file custom.el file containing variables from Emacs customize

(load custom-file)

;; Install Straight.el to manage packages

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Set up use-package to manage package loading

(straight-use-package 'use-package)

;; Emacs Startup Tools

(use-package benchmark-init
  :straight t
  :config
  ;; (benchmark-init/activate)
  (add-hook 'after-init-hook #'benchmark-init/deactivate))

(use-package no-littering
  :straight (no-littering :host github
                          :repo "emacscollective/no-littering"
                          :branch "master"))

(use-package whicher
  :straight (whicher :host github
                     :repo "tfree87/whicher"
                     :branch "master")
  :custom
  (whicher-report-new-buffer t))

(use-package emacs
  :custom
  (ring-bell-function #'ignore)
  (visible-bell t)
  (bidi-paragraph-direction 'left-to-right)
  ;;(desktop-save-mode t)
  (delete-by-moving-to-trash t)
  (version-control t)
  (delete-old-versions t)
  (vc-make-backup-files t)
  (inhibit-startup-screen t)
  (register-preview-delay 0)
  (register-preview-function #'consult-register-format)
  (xref-show-xrefs-function #'consult-xref)
  (xref-show-definitions-function #'consult-xref)
  (completion-cycle-threshold t)
  (tab-always-indent 'complete)
  (column-number-mode t)
  (sentence-end-double-space nil)
  (display-time-mode t)
  (display-time-and-date t)
  (mail-user-agent 'mu4e-user-agent)
  :config
  (add-hook 'before-save-hook 'time-stamp)
  (if (version<= "27.1" emacs-version)
      (setq bidi-inhibit-bpa t))
  (fset 'yes-or-no-p 'y-or-n-p)
  (advice-add #'register-preview
              :override #'consult-register-window)
  (setq-default indent-tabs-mode nil)
  (when (version<= "26.0.50" emacs-version)
    (add-hook 'prog-mode-hook 'display-line-numbers-mode))
  (recentf-mode 1)
  (winner-mode t)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (toggle-scroll-bar -1)
  (set-variable 'read-mail-command 'mu4e))

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
  :config
  (setq consult-project-root-function
        (lambda ()
          (when-let (project (project-current))
            (car (project-roots project)))))
  (setq consult-narrow-key "<"))

(use-package consult-notes
  :straight (:type git :host github :repo "mclear-tools/consult-notes")
  :after consult
  :commands (consult-notes
             consult-notes-search-all
             consult-notes-org-roam-find-node
             consult-notes-org-roam-find-node-relation)
  :config
  (setq consult-notes-data-dirs '(("GTD"  ?g  "~/Dropbox/gtd/")
                             ("Org Roam"  ?r  "~/Dropbox/org-roam/")))
  (consult-notes-org-roam-mode))

(use-package consult-yasnippet
  :straight t
  :after (consult yasnippet)
  :commands (consult-yasnippet))

(use-package consult-flycheck
  :straight t
  :commands (consult-flycheck)
  :after (consult flycheck))

(use-package corfu
  :straight t
  :hook
  (eshell-mode-hook . (lambda ()
                        (setq-local corfu-quit-at-boundary t
                                    corfu-quit-no-match t
                                    corfu-auto nil)
                        (corfu-mode)))
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous))
  :custom
  (corfu-auto t)
  (corfu-cycle t)
  (corfu-preselect-first nil)
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous))
  :init
  (global-corfu-mode)
  :config
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-silent)
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

(use-package orderless
  :straight t
  :defer 3
  :custom
  (completion-styles '(orderless))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package marginalia
  :straight t
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

(use-package vertico
  :straight t
  :demand t
  :custom
  (vertico-cycle t)
  (vertico-resize t)
  :init
  (vertico-mode))

(use-package aggressive-indent
  :straight t
  :hook
  (c-mode . aggressive-indent-mode)
  (emacs-lisp-mode . aggressive-indent-mode)
  (go-mode . aggressive-indent-mode))

(use-package apheleia
  :straight t
  :hook
  (prog-mode . apheleia-mode)
  (tex-mode . apheleia-mode)
  :config
  (setf (alist-get 'black apheleia-formatters)
  '("black" "--experimental-string-processing" "-")))

(use-package c-mode
  :straight (:type built-in)
  :defer t
  :mode ("\\.c\\'"
         "\\.ino\\'"))

(use-package eglot
  :straight t
  :hook
  (python-mode . eglot-ensure))

(use-package flycheck
  :straight t
  :hook
  (prog-mode . flycheck-mode))

(use-package go-mode
  :straight t
  :defer t)

(use-package minimap
  :straight t
  :defer t)

(use-package magit
  :init
  (whicher "git")
  :straight t
  :bind ("C-x g" . magit-status))

(use-package numpydoc
  :straight t
  :bind (:map python-mode-map
              ("C-c C-n" . numpydoc-generate)))

(use-package paren
  :straight (:type built-in)
  :defer t
  :custom
  (show-paren-delay 0)
  :hook (prog-mode . show-paren-mode))

(use-package rainbow-delimiters
  :straight t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package treemacs
  :straight t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :custom
  (treemacs-show-hidden-files t)
  (treemacs-wide-toggle-width 60)
  (treemacs-width 30)
  (treemacs-width-is-initially-locked nil)
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  (treemacs-fringe-indicator-mode 'always)
  (treemacs-hide-gitignored-files-mode nil)
  :config
  (treemacs-load-theme "all-the-icons")
  (pcase (cons (not (null (executable-find "git")))
               (not (null treemacs-python-executable)))
    (`(t . t)
     (treemacs-git-mode 'deferred))
    (`(t . _)
     (treemacs-git-mode 'simple)))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-all-the-icons
  :after treemacs
  :straight t
  :config (treemacs-load-theme 'all-the-icons))

(use-package treemacs-magit
  :after (treemacs magit)
  :straight t)

(use-package dired
  :straight (:type built-in)
  :defer t
  :custom
  (dired-dwim-target t))

(use-package dired-collapse
  :straight t
  :after dired
  :hook
  (dired-mode . dired-collapse-mode))

(use-package dired-open
  :straight t
  :after dired
  :init
  (whicher "xdg-open")
  :config
  (define-key dired-mode-map (kbd "o") #'dired-open-xdg))

(use-package disk-usage
  :straight t
  :defer t)

(use-package rclone-tools
  :straight (rclone-tools :host github
                          :repo "tfree87/emacs-rclone-tools"
                          :branch "main")
  :init (whicher "rclone"))

(defun rclone-sync (source dest &optional rclone-path rclone-config)
  "Sync DEST with SOURCE using rclone.
The path to the rlcone executable can be set with RCLONE-PATH.
The rclone configuration can be set with RCLONE-CONFIG."
  (interactive)
  (let ((rclone-path (or rclone-path "rclone"))
        (rclone-config (or rclone-config nil))
        (config-option
         (if rclone-config
             (concat " --config " rclone-config)
           (nil))))
    (eshell-command
     (concat rclone-path
             config-option
             " -vP sync "
             source
             " "
             dest))))

(use-package sunrise-commander
  :defer t
  :straight t
  :custom
  (sr-windows-locked nil)
  :config
  (define-key sr-mode-map (kbd "o") #'dired-open-xdg))

(use-package bufler
  :straight t
  :bind ("C-x C-b" . bufler))

(use-package burly
  :straight (burly :host github
                   :repo "tfree87/burly.el"
                   :branch "master")
  :commands (burly-bookmark-frames
             burly-bookmark-windows
             burly-open-bookmark))

(use-package winum
  :straight t
  :defer 3
  :config
  (winum-mode t))

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

(use-package deft
  :straight t
  :after org
  :disabled t
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

(use-package habitica
  :straight t
  :after org
  :custom
  (habitica-turn-on-highlighting t)
  (habitica-show-streak t))

(use-package org
  :defer t
  :init
  (whicher "pdflatex")
  (whicher "biber")
  :bind
  ("C-c l" . #'org-store-link)
  ("C-c a" . #'org-agenda)
  ("C-c c" . #'org-capture)
  :custom
  (org-directory "~/Dropbox/gtd")
  (org-agenda-start-on-weekday nil)
  (org-agenda-files `("~/Dropbox/gtd"))
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
  ;; (org-startup-indented t)
  (org-src-tab-acts-natively t)
  (org-todo-keyword-faces
   '(("TODO" . org-warning)
     ("WAITING" . "yellow")
     ("CANCELED" . (:foreground "blue" :weight bold))
     ("DONE" . org-done)))
  (org-capture-templates
   '(("p" "Projects item" entry (file "~/Dropbox/gtd/projects.org")
      "* %? :project:")
     ("s" "Someday/Maybe item" entry (file "~/Dropbox/gtd/someday.org")
      "* %?\n%x")
     ("T" "Tickler file item" entry (file "~/Dropbox/gtd/tickler.org")
      "* %?\n%^{Scheduled}t\n%x")
     ("t" "To Do Item" entry (file+headline "~/Dropbox/gtd/inbox.org" "Tasks")
      "* TODO %? %^G\nSCHEDULED: %^{Scheduled}t DEADLINE: %^{Deadline}t\n%x")))
  (org-cite-global-bibliography '("~/bib/bib.bib"))
  (org-cite-insert-processor 'citar)
  (org-cite-follow-processor 'citar)
  (org-cite-activate-processor 'citar)
  (org-plantuml-jar-path (expand-file-name "~/.emacs.d/plantuml/plantuml.jar"))
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
  (ox-extras-activate '(ignore-headlines))
  (require 'org-contacts)
  (setq org-contacts-files '("~/Dropbox/contacts.org")))

(use-package org-mind-map
  :straight t
  :after org
  :commands org-mind-map-write
  :init
  (require 'ox-org)
  :custom
  (org-mind-map-engine "dot"))

(use-package org-roam
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

(use-package academic-phrases
  :straight t
  :defer t)

(use-package auctex
  :straight t
  :defer t
  :custom
  (TeX-auto-save t)
  (TeX-parse-self t)
  (TeX-master nil)
  (bibtex-dialect 'biblatex))

(use-package citar
  :straight t
  :after org
  :custom
  (citar-bibliography org-cite-global-bibliography))

(use-package ispell
  :straight (:type built-in)
  :defer t
  :config
  (if (eq system-type 'windows-nt)
    (progn (setq ispell-program-name (expand-file-name "~/.emacs.d/hunspell/bin/hunspell.exe"))
           (setq ispell-personal-dictionary "~/.emacs.d/hunspell_en_US")
           (setq ispell-local-dictionary "en_US")
           (setq ispell-local-dictionary-alist
                 '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8))))
      (setq ispell-program-name (whicher "hunspell"))))

(use-package flyspell
  :straight (:type built-in)
  :defer t
  :init
  (add-hook 'prog-mode-hook 'flyspell-prog-mode)
  (add-hook 'text-mode-hook 'flyspell-mode))

(use-package markdown-mode
  :straight t
  :mode ("\\.\\(m\\(ark\\)?down\\|md\\)$" . markdown-mode)
  :init
  (whicher "pandoc")
  (setq markdown-command '("pandoc" "--from=markdown" "--to=html5"))
  :config
  (bind-key "A-b" (surround-text-with "+*") markdown-mode-map)
  (bind-key "s-b" (surround-text-with "**") markdown-mode-map)
  (bind-key "A-i" (surround-text-with "*") markdown-mode-map)
  (bind-key "s-i" (surround-text-with "*") markdown-mode-map)
  (bind-key "A-=" (surround-text-with "`") markdown-mode-map)
  (bind-key "s-=" (surround-text-with "`") markdown-mode-map))

(use-package pdf-tools
  :magic ("%PDF" . pdf-view-mode)
  :config
  (pdf-loader-install :no-query))

(use-package eshell
  :straight (:type built-in)
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

(use-package esh-autosuggest
  :straight t
  :hook (eshell-mode . esh-autosuggest-mode))

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
  (eshell-toggle-run-command nil)
  (eshell-toggle-init-function #'eshell-toggle-init-eshell)
  :bind
  ("M-s-`" . eshell-toggle))

(use-package oh-my-eshell
  :straight (oh-my-eshell :repo "tfree87/OhMyEshell"
                          :branch "main"
                          :host github)
  :after eshell)

(use-package powershell
  :straight t
  :if (eq system-type 'windows-nt)
  :defer t
  :init
  (whicher "powershell.exe")
  :config
  ;; Change default compile command for powershell
  (add-hook 'powershell-mode-hook
            (lambda ()
              (set (make-local-variable 'compile-command)
                   (format
                     "powershell.exe -NoLogo -NonInteractive -Command \"& '%s'\"")
                    (buffer-file-name)))))

(use-package vterm
  :defer t)

(use-package all-the-icons
  :straight t
  :if (not (string= (getenv "EMACS_PORTABLE") "Y"))
  :defer t)

(use-package all-the-icons-dired
  :straight t
  :if (not (string= (getenv "EMACS_PORTABLE") "Y"))
  :hook
  (dired-mode . all-the-icons-dired-mode))

(use-package all-the-icons-ibuffer
  :straight t
  :if (not (string= (getenv "EMACS_PORTABLE") "Y"))
  :hook (ibuffer-mode . all-the-icons-ibuffer-mode))

(use-package all-the-icons-completion
  :straight t
  :if (not (string= (getenv "EMACS_PORTABLE") "Y"))
  :defer 3
  :config
  (all-the-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup))

(custom-theme-set-faces
 'user
 '(default ((t (:family "Source Code Pro" :foundry "outline" :slant normal :weight normal :height 100 :width normal)))))

(cond ((eq system-type 'windows-nt)
       (custom-theme-set-faces
        'user
        '(variable-pitch ((t (:family "Times New Roman"))))
        '(fixed-pitch ((t (:family "Source Code Pro"))))))
      ((eq system-type 'gnu/linux)
      (custom-theme-set-faces
       'user
       '(variable-pitch ((t (:family "Source Serif Pro"))))
       '(fixed-pitch ((t (:family "Source Code Pro")))))))

(custom-theme-set-faces
 'user
 '(sr-active-path-face ((t (:foreground "yellow" :weight bold :height 120))))
 '(sr-highlight-path-face ((t (:background "yellow" :foreground "dark violet" :weight bold :height 120))))
 '(sr-passive-path-face ((t (:foreground "lightgray" :weight bold :height 120)))))

(use-package doom-themes
  :straight t
  :if window-system
  :defer 1
  :config
  (load-theme 'doom-outrun-electric t)
  (doom-themes-org-config))

(use-package doom-modeline
  :straight t
  :if window-system
  :defer 1
  :config (doom-modeline-mode))

(use-package mixed-pitch
  :straight t
  :hook
  (org-mode . mixed-pitch-mode))

(use-package nyan-mode
  :straight t
  :if window-system
  :defer 3
  :init
  ;; Requires mplayer to play the music
  (whicher "mplayer")
  :custom
  (nyan-wavy-trail t)
  :config
  (nyan-mode)
  (nyan-start-animation))

(use-package olivetti
  :straight t
  :hook
  (org-mode . olivetti-mode))

(use-package org-modern
  :straight t
  :after org
  :custom
  (org-auto-align-tags nil)
  (org-catch-invisible-edits 'show-and-error)
  (org-special-ctrl-a/e t)
  (org-insert-heading-respect-content t)

  (org-pretty-entities t)
  (org-ellipsis "…")

  (org-agenda-tags-column 0)
  (org-agenda-block-separator ?─)
  (org-agenda-time-grid
   '((daily today require-timed)
     (800 1000 1200 1400 1600 1800 2000)
     " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄"))
  (org-agenda-current-time-string
   "⭠ now ─────────────────────────────────────────────────")
:config
(defun fm/org-header-formatting ()
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
(global-org-modern-mode)
(fm/org-header-formatting))

(use-package org-superstar
  :straight t
  :after org
  :disabled t
  :custom
  (org-superstar-prettify-item-bullets t)
  (org-superstar-item-bullet-alist '((?* . ?•)
                                     (?+ . ?➤)
                                     (?- . ?•)))
  :hook
  (org-mode . org-superstar-mode))

(use-package gnus
  :straight (:type built-in)
  :defer t
  :hook
  (dired-mode . turn-on-gnus-dired-mode)
  :custom
  (gnus-icalendar-org-capture-file "~/Dropbox/gtd/inbox.org")
  (gnus-icalendar-org-capture-headline '("Calendar"))
  :config
  (require 'gnus-icalendar)
  (gnus-icalendar-setup)
  (gnus-icalendar-org-setup))

(use-package mu4e
  :defer t
  :custom
  (mu4e-maildir (expand-file-name "~/Mail"))
  (mu4e-get-mail-command "mbsync -c ~/.emacs.d/mu4e/.mbsyncrc -a")
  (mu4e-view-prefer-html t)
  (mu4e-view-show-images t)
  ;; Update every 5 minutes
  (mu4e-update-interval 300)
  (mu4e-headers-auto-update t)
  (mu4e-compose-signature-auto-include t)
  (mu4e-compose-format-flowed t)
  (mu4e-compose-in-new-frame t)
  (mu4e-sent-messages-behavior 'delete)
  (mu4e-attachment-dir  "~/Downloads")
  (mu4e-change-filenames-when-moving t)
  (message-kill-buffer-on-exit t)
  (mu4e-compose-dont-reply-to-self t)
  :config
  (require 'mu4e-icalendar)
  (mu4e-icalendar-setup)
  (setq mu4e-org-contacts-file  "~/Dropbox/contacts.org")
   (add-to-list 'mu4e-headers-actions
     '("org-contact-add" . mu4e-action-add-org-contact) t)
   (add-to-list 'mu4e-view-actions
     '("org-contact-add" . mu4e-action-add-org-contact) t)
  (load "~/.emacs.d/mu4e/mu4e-contexts.el")
  (require 'mu4e-speedbar)
  ;; Add option to view emails in browser
  (add-to-list 'mu4e-view-actions
               '("ViewInBrowser" . mu4e-action-view-in-browser) t))

(use-package org-mime
  :straight t
  :commands (org-mime-htmlize
             org-mime-org-buffer-htmlize
             org-mime-org-subtree-htmlize))

(use-package docker
  :straight t
  :init
  (whicher "docker")
  :bind ("C-c d" . docker))

(use-package docker-compose-mode
  :straight t
  :defer t
  :init
  (whicher "docker-compose"))

(use-package emms
  :straight t
  :defer t
  :custom
  (emms-source-file-default-directory "~/Music/")
  :config
  (require 'emms-setup)
  (emms-all)
  (emms-default-players)
  (global-set-key (kbd "<XF86AudioPrev>") 'emms-previous)
  (global-set-key (kbd "<XF86AudioNext>") 'emms-next)
  (global-set-key (kbd "<XF86AudioPlay>") 'emms-pause))

(use-package gnuplot
  :straight t
  :init
  (whicher "gnuplot")
  :defer t)

(use-package helpful
  :straight t
  :defer t
  :bind
  ("C-h f" . #'helpful-callable)
  ("C-h v" . #'helpful-variable)
  ("C-h k" . #'helpful-key)
  ("C-c C-d" . #'helpful-at-point)
  ("C-h F" . #'helpful-function)
  ("C-h C" . #'helpful-command))

(use-package ledger-mode
  :straight t
  :defer t
  :init
  (whicher "ledger"))

(use-package multiple-cursors
  :straight t
  :defer t
  :bind
  ("C-S-c C-S-c" . 'mc/edit-lines)
  ("C->" . 'mc/mark-next-like-this)
  ("C-<" . 'mc/mark-previous-like-this)
  ("C-c C-<" . 'mc/mark-all-like-this))

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
            "\\*Whicher Report\\*"
            help-mode
            compilation-mode))
  (popper-mode +1)
  (popper-echo-mode +1))

(use-package savehist
  :straight (:type built-in)
  :init
  (savehist-mode))

(use-package which-key
  :straight t
  :defer 3
  :custom
  (which-key-show-early-on-C-h t)
  :config
  (global-set-key (kbd "<f4>") 'which-key-show-major-mode)
  (which-key-setup-side-window-right-bottom)
  (which-key-mode))

(use-package yasnippet
  :straight t
  :defer 3
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :straight t
  :defer t)

(use-package app-launcher
  :straight '(app-launcher :host github
                           :repo "SebastienWae/app-launcher"
                           :branch "main")
  :commands (app-launcher))

(use-package exwm
  :if
  (and (not
        (string=
         (substring
          (shell-command-to-string
           (whicher "wmctrl -m ; echo $?"))
          -2 -1) "0"))
       (eq window-system 'x))
  :custom
  (exwm-workspace-number 1)
  (exwm-input-global-keys
   `(([?\s-r] . exwm-reset)
     ([s-left] . windmove-left)
     ([s-right] . windmove-right)
     ([s-up] . windmove-up)
     ([s-down] . windmove-down)
     ([?\s-w] . exwm-workspace-switch)
     ([?\s-e] . app-launcher-run-app)))
  (exwm-input-prefix-keys
   '(?\C-x
     ?\C-u
     ?\C-h
     ?\M-x
     ?\M-`
     ?\M-&
     ?\M-:
     ?\C-\M-j
     ?\C-\ ))
  :config
  (display-battery-mode t)
  (add-hook
   'exwm-update-class-hook (lambda()
                             (exwm-workspace-rename-buffer
                              exwm-class-name)))
  (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)
  (require 'exwm-randr)
  (exwm-randr-enable)
  (require 'exwm-systemtray)
  (exwm-systemtray-enable)
  (whicher "nm-applet")
  (when (executable-find "nm-applet")
    (start-process-shell-command "nm-applet" nil "nm-applet"))
  (whicher "pasystray")
  (when (executable-find "pasystray")
    (start-process-shell-command "pasystray" nil "pasystray"))
  (exwm-enable))

(use-package desktop-environment
  :straight nil
  :after exwm
  :init
  (mapc #'whicher '("amixer"
                    "brightnessctl"
                    "numlockx"
                    "scrot"
                    "slock"
                    "upower"
                    "TLP"
                    "playerctl"))
  :config
  (desktop-environment-mode)
  (shell-command "pulseaudio --kill ; pulseaudio --start")
  (shell-command "numlockx on")
  (shell-command "xinput set-prop \"SynPS/2 Synaptics TouchPad\" \"libinput Tapping Enabled\" 1"))

;; Start an Emacs server

(use-package server
  :straight (:type built-in)
  :config
  (when (not (string= (getenv "EMACS_PORTABLE") "Y"))
    (when (not (server-running-p))
      (server-start))))

;; Custom Function Definitions

(whicher "sudo")
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

;; Sync Dropbox containing org agenda files on load and close

(when (string= (getenv "EMACS_PORTABLE") "Y")
  (setq rclone-path "~/rclone/rclone.conf")
  (rclone-run-remote-to-local "sync" "~/Dropbox" "dropbox:")
  (add-hook 'kill-emacs-hook (rclone-run-local-to-remote "sync"
                                                         "~/Dropbox"
                                                         "dropbox:")))

(use-package meow
  :straight t
  :commands (meow-global-mode)
  :config
  (defun meow-setup ()
    (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
    (meow-motion-overwrite-define-key
     '("j" . meow-next)
     '("k" . meow-prev)
     '("<escape>" . ignore))
    (meow-leader-define-key
     ;; SPC j/k will run the original command in MOTION state.
     '("j" . "H-j")
     '("k" . "H-k")
     ;; Use SPC (0-9) for digit arguments.
     '("1" . meow-digit-argument)
     '("2" . meow-digit-argument)
     '("3" . meow-digit-argument)
     '("4" . meow-digit-argument)
     '("5" . meow-digit-argument)
     '("6" . meow-digit-argument)
     '("7" . meow-digit-argument)
     '("8" . meow-digit-argument)
     '("9" . meow-digit-argument)
     '("0" . meow-digit-argument)
     '("/" . meow-keypad-describe-key)
     '("?" . meow-cheatsheet))
    (meow-normal-define-key
     '("0" . meow-expand-0)
     '("9" . meow-expand-9)
     '("8" . meow-expand-8)
     '("7" . meow-expand-7)
     '("6" . meow-expand-6)
     '("5" . meow-expand-5)
     '("4" . meow-expand-4)
     '("3" . meow-expand-3)
     '("2" . meow-expand-2)
     '("1" . meow-expand-1)
     '("-" . negative-argument)
     '(";" . meow-reverse)
     '("," . meow-inner-of-thing)
     '("." . meow-bounds-of-thing)
     '("[" . meow-beginning-of-thing)
     '("]" . meow-end-of-thing)
     '("a" . meow-append)
     '("A" . meow-open-below)
     '("b" . meow-back-word)
     '("B" . meow-back-symbol)
     '("c" . meow-change)
     '("d" . meow-delete)
     '("D" . meow-backward-delete)
     '("e" . meow-next-word)
     '("E" . meow-next-symbol)
     '("f" . meow-find)
     '("g" . meow-cancel-selection)
     '("G" . meow-grab)
     '("h" . meow-left)
     '("H" . meow-left-expand)
     '("i" . meow-insert)
     '("I" . meow-open-above)
     '("j" . meow-next)
     '("J" . meow-next-expand)
     '("k" . meow-prev)
     '("K" . meow-prev-expand)
     '("l" . meow-right)
     '("L" . meow-right-expand)
     '("m" . meow-join)
     '("n" . meow-search)
     '("o" . meow-block)
     '("O" . meow-to-block)
     '("p" . meow-yank)
     '("q" . meow-quit)
     '("Q" . meow-goto-line)
     '("r" . meow-replace)
     '("R" . meow-swap-grab)
     '("s" . meow-kill)
     '("t" . meow-till)
     '("u" . meow-undo)
     '("U" . meow-undo-in-selection)
     '("v" . meow-visit)
     '("w" . meow-mark-word)
     '("W" . meow-mark-symbol)
     '("x" . meow-line)
     '("X" . meow-goto-line)
     '("y" . meow-save)
     '("Y" . meow-sync-grab)
     '("z" . meow-pop-selection)
     '("'" . repeat)
     '("<escape>" . ignore)))
  (meow-setup))

(setq gc-cons-threshold 800000)
)

(provide 'init)

;;; init.el ends here
