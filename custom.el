(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(bbdb-mua-interactive-action '(query . create) nil nil "Customized with use-package bbdb")
 '(custom-safe-themes
   '("da53441eb1a2a6c50217ee685a850c259e9974a8fa60e899d393040b4b8cc922" "da186cce19b5aed3f6a2316845583dbee76aea9255ea0da857d1c058ff003546" "0d01e1e300fcafa34ba35d5cf0a21b3b23bc4053d388e352ae6a901994597ab1" default))
 '(org-modules '(ol-bbdb ol-bibtex ol-docview ol-doi org-habit))
 '(safe-local-variable-values
   '((org-use-tag-inheritance)
     (eval add-hook 'after-save-hook
           (lambda nil
             (org-babel-tangle))
           nil t))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
