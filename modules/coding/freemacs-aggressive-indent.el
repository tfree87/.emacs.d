;; Install Aggressive Indent

;; [[https://github.com/Malabarba/aggressive-indent-mode][Aggressive Indent mode]] will keep code indented by the correct amount as you type in real time.

(use-package aggressive-indent
  :straight t
  :hook
  (emacs-lisp-mode . aggressive-indent-mode)
  (c-mode . aggressive-indent-mode)
  (emacs-lisp-mode . aggressive-indent-mode)
  (go-mode . aggressive-indent-mode))

;; End

;; Tell Emacs what package this file provides.

(provide 'freemacs-aggressive-indent);

;;; freemacs-aggressive-indent.el ends here.
