(use-package dired
  :straight (:type built-in)
  :defer t
  :custom
  (dired-dwim-target t))

(use-package dired-collapse
  :straight t
  :after dired
  :hook
  (dired-mode . dired-collapse-mode))

(use-package dired-open
  :straight t
  :after dired
  :init
  (whicher "xdg-open")
  :config
  (define-key dired-mode-map (kbd "o") #'dired-open-xdg))

(use-package disk-usage
  :straight t
  :defer t)

(use-package rclone-tools
  :straight (rclone-tools :host github
                          :repo "tfree87/emacs-rclone-tools"
                          :branch "main")
  :init (whicher "rclone"))

(defun rclone-sync (source dest &optional rclone-path rclone-config)
  "Sync DEST with SOURCE using rclone.
The path to the rlcone executable can be set with RCLONE-PATH.
The rclone configuration can be set with RCLONE-CONFIG."
  (interactive)
  (let ((rclone-path (or rclone-path "rclone"))
        (rclone-config (or rclone-config nil))
        (config-option
         (if rclone-config
             (concat " --config " rclone-config)
           (nil))))
    (eshell-command
     (concat rclone-path
             config-option
             " -vP sync "
             source
             " "
             dest))))

(provide 'freemacs-dired)

;;; freemacs-dired.el ends here
