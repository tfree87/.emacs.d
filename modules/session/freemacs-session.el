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

(use-package recentf
  :straight (:type built-in)
  :config
  (recentf-mode 1))

(use-package savehist
  :straight (:type built-in)
  :init
  (savehist-mode))

(use-package winum
  :straight t
  :defer 3
  :config
  (winum-mode t))

(provide 'freemacs-session)

;;; freemacs-session.el ends here
