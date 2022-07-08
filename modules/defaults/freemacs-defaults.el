(use-package emacs
  :custom
  (bidi-paragraph-direction 'left-to-right)
  (delete-by-moving-to-trash t)
  (version-control t)
  (delete-old-versions t)
  (vc-make-backup-files t)
  (inhibit-startup-screen t)
  (register-preview-delay 0)
  (ring-bell-function #'ignore)
  (visible-bell t)
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

(provide 'freemacs-defaults)

;;; freemacs-defaults.el ends here
