(use-package orderless
  :straight t
  :defer 3
  :custom
  (completion-styles '(orderless))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(provide 'freemacs-orderless)
