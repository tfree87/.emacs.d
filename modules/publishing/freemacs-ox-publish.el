(use-package htmlize
  :straight t
  :defer t)

(use-package ox-publish
  :straight (:type built-in)
  :defer t
  :after org
  :config
  (add-to-list 'load-path "~/.emacs.d/publish/")
  (require 'freemacs-ox-publish-projects))

(provide 'freemacs-ox-publish)

;;; freemacs-ox-publish.el ends here
