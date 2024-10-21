(use-package centered-window
  :straight t
  :custom
  (cwm-incremental-padding t)
  (cwm-incremental-padding-% 5)
  (cwm-centered-window-width 1000)
  :config
  (centered-window-mode t))

(provide 'freemacs-cwm)
