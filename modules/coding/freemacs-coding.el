(use-package aggressive-indent
  :straight t
  :hook
  (emacs-lisp-mode . aggressive-indent-mode)
  (c-mode . aggressive-indent-mode)
  (emacs-lisp-mode . aggressive-indent-mode)
  (go-mode . aggressive-indent-mode))

(use-package apheleia
  :straight (apheleia :host github
                      :repo "radian-software/apheleia"
                      :branch "main")
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

; (use-package eglot
;   :straight t
;   :hook
;   (python-mode . eglot-ensure))

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

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(use-package numpydoc
  :straight t
  :defer t
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

(use-package treemacs-magit
  :after (treemacs magit)
  :defer t
  :straight t)

(use-package indent-bars
  :straight (:host github :repo "jdtsmith/indent-bars"
                   :branch "main")
  :hook (python-mode . indent-bars-mode)
  :custom
  (indent-bars-prefer-character t))

(provide 'freemacs-coding)

;;; freemacs-coding.el ends here
