(use-package emacs
  :custom
  (bidi-paragraph-direction 'left-to-right)
  (version-control t)
  (delete-old-versions t)
  (vc-make-backup-files t)
  (register-preview-delay 0)
  (ring-bell-function #'ignore)
  (visible-bell t)
  (delete-by-moving-to-trash t)
  (column-number-mode t)
  :config
  (add-hook 'before-save-hook 'time-stamp)
  (if (version<= "27.1" emacs-version)
      (setq bidi-inhibit-bpa t))
  (setq-default indent-tabs-mode nil)
  (fset 'yes-or-no-p 'y-or-n-p))

(use-package battery
  :straight (:type built-in)
  :defer 3
  :config
  (display-battery-mode t))

(use-package ibuffer
  :straight (:type built-in)
  :bind
  ("C-x C-b" . ibuffer))

(provide 'freemacs-defaults)

;;; freemacs-defaults.el ends here
