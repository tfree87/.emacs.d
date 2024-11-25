(use-package paren
  :straight (:type built-in)
  :defer t
  :custom
  (show-paren-delay 0)
  :hook (prog-mode . show-paren-mode))

;; Install Rainbow Delimiters

;; [[https://github.com/Fanael/rainbow-delimiters][Rainbow delimiters]] colors delimiters such as brackets and parentheses in source code making it easier to identify which delimiters are paired.

(use-package rainbow-delimiters
  :straight t
  :hook (prog-mode . rainbow-delimiters-mode))

(provide 'freemacs-parens)
