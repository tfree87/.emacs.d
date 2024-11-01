(use-package org-super-links
  :straight (org-super-links :type git :host github :repo "toshism/org-super-links" :branch "develop")
  :bind (("C-c s s" . org-super-links-link)
         ("C-c s l" . org-super-links-store-link)
         ("C-c s C-l" . org-super-links-insert-link)))

(provide'freemacs-orgsl)
