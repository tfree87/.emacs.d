;; -*- lexical-binding: t -*-

(use-package which-key
  :straight t
  :defer 3
  :if (version< emacs-version "30")
  :config
  (which-key-setup-side-window-bottom)
  (which-key-mode))

(use-package repeat-help
  :straight t
  :if (not (version< emacs-version "28"))
  :custom
  (repeat-help-auto t)
  :hook (repeat-mode . repeat-help-mode))

(provide 'freemacs-wk)

;;; freemacs-wk.el ends here.
