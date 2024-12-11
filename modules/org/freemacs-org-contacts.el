(use-package org-contacts
  :straight (:host github :repo "tfree87/org-contacts"
                   :branch "master")
  :defer t
  :commands (org-contacts org-contacts-agenda)
  :custom
  (org-contacts-files '("~/org/contacts.org")))

(provide 'freemacs-org-contacts)

;;; freemacs-org-contacts.el ends here.
