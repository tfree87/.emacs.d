;; -*- lexical-binding: t -*-

(use-package nyan-mode
  :straight t
  :if window-system
  :defer 3
  :init
  (whicher "mplayer")
  :custom
  (nyan-wavy-trail t)
  :config
  (nyan-mode)
  (nyan-start-animation))

(provide 'freemacs-nyan)

;;; freemacs-nyan.el ends here.
