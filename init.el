;; -*- lexical-binding: t -*-
;; 
;;; init.el --- Emacs initialzation file

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

(setq package-enable-at-startup nil)

(straight-use-package 'use-package)

;; Set the location of variables set using Emacs cusmtomize interface

(setq custom-file "~/.emacs.d/custom.el")

;; Load the file custom.el file containing variables from Emacs customize

(load custom-file)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; use-package statements
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package benchmark-init
  :straight t
  :hook
  (after-init . benchmark-init/deactivate))

(use-package emacs
  :init
  (setq tab-always-indent 'complete)
  (setq completion-cycle-threshold 6)
  :custom
  (delete-by-moving-to-trash t)
  (version-control t)
  (delete-old-versions t)
  (vc-make-backup-files t)
  (sentence-end-double-space nil)
  (dired-dwim-target t)
  :config
  (when (version<= "26.0.50" emacs-version )
    (global-display-line-numbers-mode))
  (add-hook 'before-save-hook 'time-stamp)
  (fset 'yes-or-no-p 'y-or-n-p)
  (display-time-mode 1)
  (menu-bar-mode -1)
  (tool-bar-mode -1)
  (toggle-scroll-bar -1))

(use-package all-the-icons
  :if (and window-system (not (file-exists-p "~/runemacs.bat")))
:straight t)

(use-package all-the-icons-dired
  :if (and window-system (not (file-exists-p "~/runemacs.bat")))
  :straight t
  :hook
  (dired-mode . all-the-icons-dired-mode))

(use-package all-the-icons-ibuffer
  :if (and window-system (not (file-exists-p "~/runemacs.bat")))
  :straight t
  :init (all-the-icons-ibuffer-mode 1))

(use-package all-the-icons-completion
  :if (and window-system (not (file-exists-p "~/runemacs.bat")))
  :straight t
  :config
  (all-the-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup))

(use-package doom-themes
  :if window-system
  :straight t
  :init (load-theme 'doom-vibrant))

(use-package doom-modeline
  :if window-system
  :straight t
  :init (doom-modeline-mode))

(use-package spacemacs-theme
  :disabled t
  :if window-system
  :straight t
  :defer t
  :init (load-theme 'spacemacs-dark t))

(use-package spaceline
  :if window-system
  :disabled t
  :straight t
  :config  
  (require 'spaceline-config)
  (spaceline-emacs-theme))

(use-package nyan-mode
  :if window-system
  :straight t
  ;; :commands nyan-mode
  :custom
  (nyan-wavy-trail t)
  :config
  (nyan-mode)
  (nyan-start-animation))

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
  (python-shell-interpreter "ipython")
  (python-shell-interpreter-args "-i --simple-prompt")
  (elpy-formatter 'black)
  :config
  (when (load "flycheck" t t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode))
  (add-hook 'elpy-mode-hook (lambda ()
                                (add-hook 'before-save-hook
                                          'elpy-black-fix-code nil t))))

(use-package flycheck
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
  :custom
  (show-paren-delay 0)
  :config
  (show-paren-mode 1))

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
      ;; (setq-local corfu-auto nil) Enable/disable auto completion
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

(use-package cape
  :straight t
  ;; Bind dedicated completion commands
  :bind (("C-c p p" . completion-at-point) ;; capf
         ("C-c p t" . complete-tag)        ;; etags
         ("C-c p d" . cape-dabbrev)        ;; or dabbrev-completion
         ("C-c p f" . cape-file)
         ("C-c p k" . cape-keyword)
         ("C-c p s" . cape-symbol)
         ("C-c p a" . cape-abbrev)
         ("C-c p i" . cape-ispell)
         ("C-c p l" . cape-line)
         ("C-c p w" . cape-dict)
         ("C-c p \\" . cape-tex)
         ("C-c p _" . cape-tex)
         ("C-c p ^" . cape-tex)
         ("C-c p &" . cape-sgml)
         ("C-c p r" . cape-rfc1345))
  :init
  ;; Add `completion-at-point-functions', used by `completion-at-point'.
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-tex)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  (add-to-list 'completion-at-point-functions #'cape-sgml)
  ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)
  ;;(add-to-list 'completion-at-point-functions #'cape-abbrev)
  (add-to-list 'completion-at-point-functions #'cape-ispell)
  ;;(add-to-list 'completion-at-point-functions #'cape-dict)
  (add-to-list 'completion-at-point-functions #'cape-symbol)
  (add-to-list 'completion-at-point-functions #'cape-line)
)

(use-package embark
  :straight t
  :bind
  (("C-." . embark-act)
   ("C-;" . embark-dwim)
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

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

;; `+orderless-dispatch' in the Consult wiki for an advanced Orderless style
;; dispatcher. Additionally enable `partial-completion' for file path
;; expansion. `partial-completion' is important for wildcard support.
;; Multiple files can be opened at once with `find-file' if you enter a
;; wildcard. You may also give the `initials' completion style a try.
(use-package orderless
  :straight t
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-dispatch)
  ;;	   orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

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

(use-package consult
  :straight t
  :bind (;; C-c bindings (mode-specific-map)
         ("C-c h" . consult-history)
         ("C-c m" . consult-mode-command)
         ("C-c k" . consult-kmacro)
         ;; C-x bindings (ctl-x-map)
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ("<help> a" . consult-apropos)            ;; orig. apropos-command
         ;; M-g bindings (goto-map)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings (search-map)
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
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi))           ;; needed by consult-line to detect isearch

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI. You may want to also
  ;; enable `consult-preview-at-point-mode` in Embark Collect buffers.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
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

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key (kbd "M-."))
  ;; (setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>")))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme
   :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-recent-file consult--source-project-recent-file consult--source-bookmark
   :preview-key (kbd "M-."))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; (kbd "C-+")

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)

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

(use-package dired+
  :if (memq window-system '(w32 pc ns))
  :defer t
  :load-path "~/.emacs.d/elisp")

(use-package docker
  :if (executable-find "docker")
  :straight t
  :bind ("C-c d" . docker))

(use-package docker-compose-mode
  :defer t
  :straight t)

(use-package use-package-ensure-system-package
  :if (and window-system (not (file-exists-p "~/runemacs.bat")))
  :straight t)

(use-package eshell
  :defer t
  :hook
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
                   (eshell/alias "ll" "ls -AlohG")))
  :custom
  (eshell-error-if-no-glob t)
  (eshell-hist-ignoredups t)
  (eshell-save-history-on-exit t)
  (eshell-destroy-buffer-when-process-dies t)
  (eshell-prompt-function
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
      (propertize (if (= (user-uid) 0) " # " " $ ") 'face `(:foreground "green")))))  
  :config
  (setenv "PAGER" "cat"))

(use-package em-smart
  :defer t
  :custom
  (eshell-smart-space-goes-to-end t)
  (eshell-where-to-jump 'begin)
  (eshell-review-quick-commands nil))

(use-package flyspell
  :if (and window-system (not (file-exists-p "~/runemacs.bat")))
  :delight
  :config
  (add-hook 'text-mode-hook 'flyspell-mode)
  (add-hook 'prog-mode-hook 'flyspell-prog-mode))

(use-package gnus
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
  :defer t
  :bind
  ("C-x C-b" . ibuffer)
  :hook
  ;; Start ibuffer with default groupings
  (ibuffer-mode .  (lambda ()
                          (ibuffer-switch-to-saved-filter-groups "default")))
  :custom
  ;; Create default groupings for ibuffer
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

(use-package tex
  :defer t
  :ensure auctex
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
  :straight t)

(use-package org-bullets
  :if window-system
  :straight t
  :after org
  :hook
  (org-mode . (lambda () (org-bullets-mode 1))))

(use-package calfw
  :disabled t
  :straight t
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
  :disabled t
  :straight t
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
  :ensure-system-package (gvgen . graphviz)
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

(use-package treemacs
  :after treemacs-all-the-icons
  :straight t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (treemacs-load-theme "all-the-icons")
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                5000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

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
  :straight t)

(use-package treemacs-magit
  :after (treemacs magit)
  :straight t)

(use-package centaur-tabs
  :straight t
  :demand
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward)
  :custom
  (centaur-tabs-set-bar 'over)
  (centaur-tabs-style "chamfer")
  :config
  (centaur-tabs-mode t))

(use-package tramp
  :config
  (eval-after-load 'tramp '(setenv "SHELL" "/bin/bash")))

(use-package which-key
  :straight t
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
  :config
  (yas-global-mode t))

(use-package yasnippet-snippets
  :straight t)

(load-file "~/.emacs.d/elisp/oh-my-zsh.el")

(setq gc-cons-threshold (* 2 1000 1000))
)
