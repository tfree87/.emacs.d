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
