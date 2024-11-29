(use-package pdf-tools
  :straight t
  :magic ("%PDF" . pdf-view-mode)
  :config
  (pdf-loader-install :no-query))

;; End

;; Tell Emacs what package this file provides.

(provide 'freemacs-pdf)

;;; freemacs-pdf.el ends here
