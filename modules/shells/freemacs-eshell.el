(use-package eshell
  :straight (:type built-in)
  :defer t
  :commands eshell
  :hook
  (eshell-load . (lambda ()
                        (eshell-git-prompt-use-theme 'multiline2)))
  (eshell-mode . (lambda ()
                   (add-to-list 'eshell-visual-commands "htop")
                   (add-to-list 'eshell-visual-commands "ipython")
                   (add-to-list 'eshell-visual-commands "rclone")
                   (add-to-list 'eshell-visual-commands "ssh")
                   (add-to-list 'eshell-visual-commands "tail")
                   (add-to-list 'eshell-visual-commands "top")
                   (eshell/alias "ff" "find-file $1")
                   (eshell/alias "emacs" "find-file $1")
                   (eshell/alias "untar" "tar -zxvf")
                   (eshell/alias "cpv" "rsync -ah --info=progress2")
                   (eshell/alias "ll" "ls -Alh")))
  :custom
  (eshell-error-if-no-glob t)
  (eshell-hist-ignoredups t)
  (eshell-save-history-on-exit t)
  (eshell-destroy-buffer-when-process-dies t)
  :config
  (setenv "PAGER" "cat"))

(use-package esh-autosuggest
  :straight t
  :hook (eshell-mode . esh-autosuggest-mode))

(use-package eshell-git-prompt
  :straight (emacs-git-prompt :host github
                              :repo "tfree87/eshell-git-prompt"
                              :branch "master")
  :defer t)

(use-package eshell-toggle
  :straight (eshell-toggle :repo "4DA/eshell-toggle"
                           :host github
                           :repo "master")
  :custom
  (eshell-toggle-size-fraction 3)
  (eshell-toggle-run-command nil)
  (eshell-toggle-init-function #'eshell-toggle-init-eshell)
  :bind
  ("M-s-`" . eshell-toggle))

(use-package oh-my-eshell
  :straight (oh-my-eshell :repo "tfree87/OhMyEshell"
                          :branch "main"
                          :host github)
  :after eshell)

(provide 'freemacs-eshell)
