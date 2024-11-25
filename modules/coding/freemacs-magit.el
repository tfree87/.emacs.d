;; Install Magit

;; [[https://magit.vc/][Magit]] provides an interface to Git through Emacs.

(use-package magit
  :init
  (whicher "git")
  :straight t
  :bind ("C-x g" . magit-status))

;; End

;; Tell Emacs what package this file provides.

(provide 'freemacs-magit)
