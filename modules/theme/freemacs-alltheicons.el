(use-package all-the-icons
  :straight t
  :defer 3)

(use-package all-the-icons-completion
  :straight t
  :after all-the-icons
  :config
  (all-the-icons-completion-mode)
  (when (boundp 'marginalia-mode)
    (add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup)))

(use-package all-the-icons-dired
  :straight t
  :after all-the-icons
  :hook
  (dired-mode . all-the-icons-dired-mode))

(use-package all-the-icons-ibuffer
  :straight t
  :after all-the-icons
  :hook (ibuffer-mode . all-the-icons-ibuffer-mode))

(use-package treemacs-all-the-icons
  :after treemacs
  :straight t
  :config (treemacs-load-theme 'all-the-icons))

(provide 'freemacs-alltheicons)

;;; freemacs-alltheicons.el ends here
