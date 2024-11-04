(use-package emacs
  :custom
  (bidi-paragraph-direction 'left-to-right)
  (version-control t)
  (delete-old-versions t)
  (vc-make-backup-files t)
  ;  (inhibit-startup-screen t)
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

;; Default Margin

;; Use a default left and right margin of 3 to help clean up the look of Emacs buffers near window edges.


;; [[file:freemacs-defaults.org::*Default Margin][Default Margin:1]]
(setq-default left-margin-width 3 right-margin-width 3)
;; Default Margin:1 ends here

(use-package battery
  :straight (:type built-in)
  :defer 3
  :config
  (display-battery-mode t))

(provide 'freemacs-defaults)

;;; freemacs-defaults.el ends here
