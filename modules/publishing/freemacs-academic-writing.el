(use-package academic-phrases
  :straight t
  :defer t)

(use-package citar
  :straight (citar :host github
                   :repo "emacs-citar/citar"
                   :branch "main")
  :defer t
  :after org oc
  :custom
  (citar-bibliography org-cite-global-bibliography)
  (citar-library-paths '("~/bib/files"))
  :config
  (with-eval-after-load "all-the-icons"
    (setq citar-symbols
          `((file ,(all-the-icons-faicon "file-o" :face 'all-the-icons-green :v-adjust -0.1) . " ")
            (note ,(all-the-icons-material "speaker_notes" :face 'all-the-icons-blue :v-adjust -0.3) . " ")
            (link ,(all-the-icons-octicon "link" :face 'all-the-icons-orange :v-adjust 0.01) . " ")))
    (setq citar-symbol-separator "  "))
  (setq citar-file-parser-functions
        '(citar-file--parser-default
          citar-file--parser-triplet)))

(add-to-list 'savehist-additional-variables 'citar-history)

(use-package citar-embark
  :after citart embark
  :no-require t
  :config (citar-embark-mode))

(use-package oc
  :defer t
  :custom
  (org-cite-global-bibliography '("~/bib/bib.bib"))
  (org-cite-insert-processor 'citar)
  (org-cite-follow-processor 'citar)
  (org-cite-activate-processor 'citar))

(provide 'freemacs-academic-writing)

;;; freemacs-academic-writing.el ends here
