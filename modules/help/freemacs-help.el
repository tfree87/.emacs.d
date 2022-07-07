(use-package helpful
  :straight t
  :defer t
  :bind
  ("C-h f" . #'helpful-callable)
  ("C-h v" . #'helpful-variable)
  ("C-h k" . #'helpful-key)
  ("C-c C-d" . #'helpful-at-point)
  ("C-h F" . #'helpful-function)
  ("C-h C" . #'helpful-command))

(use-package popper
  :straight t
  :bind (("C-`"   . popper-toggle-latest)
         ("M-`"   . popper-cycle)
         ("C-M-`" . popper-toggle-type))
  :init
  (setq popper-reference-buffers
          '("\\*Messages\\*"
            "\\*Embark Actions\\*"
            "Output\\*$"
            "\\*Async Shell Command\\*"
            "\\*Whicher Report\\*"
            help-mode
            compilation-mode))
  (popper-mode +1)
  (popper-echo-mode +1))

(use-package which-key
  :straight t
  :defer 3
  :custom
  (which-key-show-early-on-C-h t)
  :config
  (global-set-key (kbd "<f4>") 'which-key-show-major-mode)
  (which-key-setup-side-window-right-bottom)
  (which-key-mode))

(provide 'freemacs-help)

;;; freemacs-help.el ends here
