;; -*- lexical-binding: t -*-

(use-package repeat-help
  :straight t
  :if (not (version< emacs-version "28"))
  :custom
  (repeat-help-auto t)
  :hook (repeat-mode . repeat-help-mode))

(provide 'freemacs-rh)

;;; freemacs-rh.el ends here.
