;; Completion Nerd Icons

;; Add Nerd Icons to the minibuffer completion interface.


;; [[file:freemacs-nerdicons.org::*Completion Nerd Icons][Completion Nerd Icons:1]]
(use-package nerd-icons-completion
  :straight t
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))
;; Completion Nerd Icons:1 ends here

(use-package nerd-icons-corfu
  :straight t
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

;; Dired Nerd Icons

;; Add Nerd Icons to represent different file types in Dired Mode.


;; [[file:freemacs-nerdicons.org::*Dired Nerd Icons][Dired Nerd Icons:1]]
(use-package nerd-icons-dired
  :straight t
  :hook
  (dired-mode . nerd-icons-dired-mode))
;; Dired Nerd Icons:1 ends here

;; End

;; Tell Emacs what package this file provides.


;; [[file:freemacs-nerdicons.org::*End][End:1]]
(provide 'freemacs-nerd-icons)
;; End:1 ends here
