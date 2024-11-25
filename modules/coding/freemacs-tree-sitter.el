;; Install Tree-Sitter

;; Tree-sitter will update font faces quickly for many programming languages.

(use-package tree-sitter
  :straight t
  :if (version< emacs-version "29"))



;; Load languages for tree-sitter.

(use-package tree-sitter-langs
  :straight t
  :if (version< emacs-version "29"))

;; End

;; Tell Emacs what package this file provides.

(provide 'freemacs-tree-sitter)

;;; freemacs-tree-siiter.el ends here.
