;; Install Org-Ql

;; [[https://github.com/alphapapa/org-ql][Org-ql]] provides a query language to search Org files.


;; [[file:freemacs-org-ql.org::*Install Org-Ql][Install Org-Ql:1]]
(use-package org-ql
  :straight (:host github :repo "alphapapa/org-ql"
                   :branch "master")
  :commands (org-ql-find
             org-ql-find-path
             org-ql-find-in-agenda
             org-ql-find-in-org-directory
             org-ql-refile
             org-ql-search
             org-ql-view
             org-ql-view-sidebar
             org-ql-view-recent-items
             org-ql-sparse-tree))
;; Install Org-Ql:1 ends here

(provide 'freemacs-org-ql)
