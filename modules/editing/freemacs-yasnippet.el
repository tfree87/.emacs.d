(use-package yasnippet
  :straight t
  :defer 3
  :config
  (yas-global-mode 1))

;; Install Snippets

;; The package [[https://github.com/AndreaCrotti/yasnippet-snippets][YASnippet Snippets]] loads many pre-defined templates for YASnippet.


;; [[file:freemacs-yasnippet.org::*Install Snippets][Install Snippets:1]]
(use-package yasnippet-snippets
  :straight t
  :defer t)
;; Install Snippets:1 ends here

(provide 'freemacs-yasnippet)

;;; freemacs-editing.el ends here
