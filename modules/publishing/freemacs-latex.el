(use-package auctex
  :straight t
  :defer t
  :custom
  (TeX-auto-save t)
  (TeX-parse-self t)
  (TeX-master nil)
  (bibtex-dialect 'biblatex))

(provide 'freemacs-latex)

;;; freemacs-latex.el ends here
