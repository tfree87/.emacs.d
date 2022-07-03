(use-package academic-phrases
  :straight t
  :defer t)

(use-package citar
  :straight (citar :host github
                   :repo "emacs-citar/citar"
                   :branch "main")
  :defer t
  :after org
  :custom
  (citar-bibliography org-cite-global-bibliography))

(use-package oc
  :defer t
  :custom
  (org-cite-global-bibliography '("~/bib/bib.bib"))
  (org-cite-insert-processor 'citar)
  (org-cite-follow-processor 'citar)
  (org-cite-activate-processor 'citar))

(provide 'freemacs-academic-writing)

;;; freemacs-academic-writing.el ends here
