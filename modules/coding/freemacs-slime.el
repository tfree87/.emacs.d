(use-package slime
  :straight t
  :defer t
  :mode "\\.lisp\\'"
  :commands slime
  :config
  (setq inferior-lisp-program "/usr/bin/sbcl"))

(provide 'freemacs-slime)

;;; freemacs-slime.el ends here.
