;; Install YASnippet

;; [[https://github.com/joaotavora/yasnippet][YASnippet]] takes a small bit of text or an abbreviation and expands it into a template once the ~<TAB>~ key has been pressed. 

(use-package yasnippet
  :straight t
  :defer t
  :hook
  (org-mode . yas-minor-mode)
  (prog-mode . yas-minor-mode))

;; Install Snippets

;; The package [[https://github.com/AndreaCrotti/yasnippet-snippets][YASnippet Snippets]] loads many pre-defined templates for YASnippet.

(use-package yasnippet-snippets
  :straight t
  :after yasnippet
  :defer t)

;; End

;; Tell Emacs what package this file provides.

(provide 'freemacs-yasnippet)

;;; freemacs-editing.el ends here
