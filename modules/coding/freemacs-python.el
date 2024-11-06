;; Numpydoc

;; Using [[https://github.com/douglasdavis/numpydoc.el][Numpydoc]] provides an interactive tool to automatically generate Numpy style docstrings.

(use-package numpydoc
  :straight t
  :defer t
  :bind (:map python-mode-map
              ("C-c C-n" . numpydoc-generate)))

(provide 'freemacs-python)
