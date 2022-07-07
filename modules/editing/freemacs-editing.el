(use-package multiple-cursors
  :straight t
  :defer t
  :bind
  ("C-S-c C-S-c" . 'mc/edit-lines)
  ("C->" . 'mc/mark-next-like-this)
  ("C-<" . 'mc/mark-previous-like-this)
  ("C-c C-<" . 'mc/mark-all-like-this))

(use-package yasnippet
  :straight t
  :defer 3
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets
  :straight t
  :defer t)

(provide 'freemacs-editing)

;;; freemacs-editing.el ends here
