(use-package vterm
  :straight t
  :defer t)

(use-package multi-vterm
  :straight nil
  :defer t
  :commands (multi-vterm
             multi-vterm-project
             multi-vterm-dedicated-toggle))

(provide 'freemacs-vterm)

;;; freemacs-vterm.el ends here
