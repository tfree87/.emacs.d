(use-package whicher
  :straight (whicher :host github
                     :repo "tfree87/whicher"
                     :branch "master")
  :commands whicher-report
  :custom
  (whicher-report-new-buffer t))

(provide 'freemacs-whicher)
