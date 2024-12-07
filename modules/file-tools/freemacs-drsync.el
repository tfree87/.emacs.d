(use-package dired-rsync
  :straight t
  :after dired
  :bind (:map dired-mode-map
              ("C-c C-r" . dired-rsync)))

(use-package dired-rsync-transient
  :straight t
  :after dired
  :bind (:map dired-mode-map
              ("C-c C-x" . dired-rsync-transient)))

(provide 'freemacs-drsync)
