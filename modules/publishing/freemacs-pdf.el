(use-package pdf-tools
  :magic ("%PDF" . pdf-view-mode)
  :config
  (pdf-loader-install :no-query))

(provide 'freemacs-pdf)

;;; freemacs-pdf.el ends here
