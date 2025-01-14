;; Install Sly


(use-package sly
  :straight t
  :commands sly
  :config
  (if (eq system-type 'windows-nt)
      (setq inferior-lisp-program (whicher "C:/SBCL/sbcl.exe"))
    (setq inferior-lisp-program (whicher "/usr/bin/sbcl --noinform --no-linedit"))))


(provide 'freemacs-sly)

;;; freemacs-sly.el ends here.
