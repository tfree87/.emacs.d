;; Helpful

;; [[https://github.com/Wilfred/helpful][Helpful]] improves the Emacs help functions by adding new features to the ~*Help*~ buffer.

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

;; Popper

;; [[https://github.com/karthink/popper][Popper]] lets a user define any window as a short-term pop up window.

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

;; Which-key

;; [[https://github.com/justbur/emacs-which-key][Which-key]] provides a pop-up menu when there is a pause in the minibuffer or if executed directly to show the keyboard commands available to the current buffer.

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
