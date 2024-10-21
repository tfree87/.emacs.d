(use-package org-mind-map
  :straight t
  :after org
  :commands org-mind-map-write
  :init
  (require 'ox-org)
  :custom
  (org-mind-map-engine "dot"))

(provide 'freemacs-org-mm)
