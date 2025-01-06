;; -*- lexical-binding: t -*-

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

(provide 'freemacs-helpful)

;;; freemacs-helpful.el ends here
