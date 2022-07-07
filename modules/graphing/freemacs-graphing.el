(use-package gnuplot
  :straight t
  :init
  (whicher "gnuplot")
  :defer t)

(use-package plantuml-mode
  :straight t
  :defer t
  :after org)

(provide 'freemacs-graphing)

;;; freemacs-graphing.el ends here
