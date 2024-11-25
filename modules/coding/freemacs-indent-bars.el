(use-package indent-bars
  :straight (:host github :repo "jdtsmith/indent-bars"
                   :branch "main")
  :hook (python-mode . indent-bars-mode)
  :custom
  (when (version< emacs-version "29")
    (indent-bars-prefer-character t)))

(provide 'freemacs-indent-bars)
